import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:blake2b/blake2b_hash.dart';
import 'package:cryptography/cryptography.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/settings.dart';
import 'package:gosuto/models/wallet.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:convert/convert.dart';
import 'package:secp256k1/secp256k1.dart';

class WalletUtils {
  static Future<int> importWallet(String walletName, String password,
      [String privateKey = '', String seedPhrase = '']) async {
    String _passwordDB = '';
    String hashedPassword = '';

    String _seedPhraseDB = '';
    String hashedSeedPhrase = '';

    Settings _settings = Settings(
      seedPhrase: '',
      password: '',
      useBiometricAuth: 0,
      salt: Uint8List(0),
      iv: Uint8List(0),
    );

    // Get settings from db
    var _data = await DBHelper().getSettings();
    if (_data.isNotEmpty) {
      _settings = Settings.fromMap(_data[0]);
      _passwordDB = _settings.password;
      _seedPhraseDB = _settings.seedPhrase;
    }

    if (_settings.salt.isEmpty && _settings.iv.isEmpty) {
      _settings.salt = GosutoAes256Gcm.randomBytes(16);
      _settings.iv = GosutoAes256Gcm.randomBytes(12);
    }

    if (_passwordDB != '') {
      hashedPassword = _passwordDB;
    }

    if (_seedPhraseDB != '') {
      hashedSeedPhrase = _seedPhraseDB;
    }

    // Add password & seed phrase for the first time
    if (_passwordDB == '' && _seedPhraseDB == '') {
      Hash hashedPasswordBytes = await Sha1().hash(password.codeUnits);
      hashedPassword = hex.encode(hashedPasswordBytes.bytes);

      if (seedPhrase != '') {
        hashedSeedPhrase =
            await GosutoAes256Gcm.encrypt(seedPhrase, hashedPassword);
      }

      await DBHelper().updateSettings(
        Settings(
          seedPhrase: hashedSeedPhrase,
          password: hashedPassword,
          useBiometricAuth: _settings.useBiometricAuth,
          salt: _settings.salt,
          iv: _settings.iv,
        ),
        'all',
      );
    }

    PrivateKey _privateKey;

    if (seedPhrase != '') {
      String seedHex = bip39.mnemonicToSeedHex(seedPhrase).substring(0, 64);
      _privateKey = PrivateKey.fromHex(seedHex);
    } else {
      _privateKey = PrivateKey.fromHex(privateKey);
    }

    String publicKey = _privateKey.publicKey.toCompressedHex();

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(_privateKey.toHex(), hashedPassword);

    // Decrypt wallet
    // var decrypted = await GosutoAes256Gcm.decrypt(cipherText, hasedPassword);

    List<int> signature = 'secp256k1'.codeUnits;
    List<int> bytes = [...signature, 0, ...hex.decode(publicKey)];

    // Calculate Account Hash
    Uint8List hashedBytes =
        Blake2bHash.hash(Uint8List.fromList(bytes), 0, bytes.length);
    String accountHash = hex.encode(hashedBytes);

    int walletId = await DBHelper().insertWallet(
      Wallet(
        walletName: walletName,
        publicKey: publicKey,
        accountHash: accountHash,
        privateKey: hashedPrivateKey,
      ),
    );

    return walletId;
  }
}
