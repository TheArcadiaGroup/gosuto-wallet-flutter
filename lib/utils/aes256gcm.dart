// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:convert/convert.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/settings.dart';

const int KEY_LENGTH = 32;
const int IV_LENGTH = 12;
const int TAG_LENGTH = 16;
const int SALT_LENGTH = 16;
const int KEY_ITERATIONS_COUNT = 10000;

class GosutoAes256Gcm {
  /// Encrypts passed [cleartext] with key generated based on [password] argument
  static Future<String> encrypt(String cleartext, String password) async {
    Uint8List salt = randomBytes(SALT_LENGTH);
    Uint8List iv = randomBytes(IV_LENGTH);

    // Get salt, iv from database
    final _data = await DBHelper().getSettings();
    Settings _settings = Settings(
      password: '',
      useBiometricAuth: 0,
      salt: Uint8List(0),
      iv: Uint8List(0),
    );

    if (_data.isNotEmpty) {
      _settings = Settings.fromMap(_data[0]);

      if (_settings.salt.isNotEmpty && _settings.iv.isNotEmpty) {
        salt = _settings.salt;
        iv = _settings.iv;
      }
    } else {
      // update database
      await DBHelper().updateSettings(
        Settings(
          password: _settings.password,
          useBiometricAuth: _settings.useBiometricAuth,
          salt: salt,
          iv: iv,
        ),
        'salt',
      );
    }

    final key = await deriveKey(password, salt);
    final algorithm = AesGcm.with256bits();

    final secretBox = await algorithm.encrypt(
      utf8.encode(cleartext),
      secretKey: key,
      nonce: iv,
    );

    final List<int> result =
        salt + secretBox.nonce + secretBox.cipherText + secretBox.mac.bytes;

    return hex.encode(result);
  }

  /// Decrypts passed [ciphertext] with key generated based on [password] argument
  static Future<String> decrypt(String cipherText, String password) async {
    final cText = hex.decode(cipherText);
    final salt = cText.sublist(0, SALT_LENGTH);
    final iv = cText.sublist(SALT_LENGTH, SALT_LENGTH + IV_LENGTH);
    final mac = cText.sublist(cText.length - TAG_LENGTH);
    final text =
        cText.sublist(SALT_LENGTH + IV_LENGTH, cText.length - TAG_LENGTH);

    final algorithm = AesGcm.with256bits();
    final key = await deriveKey(password, salt);

    final secretBox = SecretBox(text, nonce: iv, mac: Mac(mac));

    final cleartext = await algorithm.decrypt(
      secretBox,
      secretKey: key,
    );

    return utf8.decode(cleartext);
  }

  /// Password Based Key Deriviation function
  static Future<SecretKey> deriveKey(String password, List<int> salt) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha512(),
      iterations: KEY_ITERATIONS_COUNT,
      bits: KEY_LENGTH * 8,
    );

    SecretKey secret = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    return secret;
  }

  /// Generates a random byte sequence of given [length]
  static Uint8List randomBytes(int length) {
    Uint8List buffer = Uint8List(length);
    Random range = Random.secure();

    for (int i = 0; i < length; i++) {
      buffer[i] = range.nextInt(256);
    }

    return buffer;
  }
}
