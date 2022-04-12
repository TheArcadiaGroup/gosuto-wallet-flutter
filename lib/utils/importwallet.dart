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
  static Future<int> importWallet(
      String walletName, String seedPhrase, String password) async {
    String seedHex = bip39.mnemonicToSeedHex(seedPhrase).substring(0, 64);
    PrivateKey privateKey = PrivateKey.fromHex(seedHex);
    String publicKey = privateKey.publicKey.toCompressedHex();
    String hashedPassword;
    String _passwordDB = '';
    Settings _settings = Settings(
      password: '',
      useBiometricAuth: 0,
      salt: Uint8List(0),
      iv: Uint8List(0),
    );

    // Get password from db
    var _data = await DBHelper().getSettings();

    if (_data.isNotEmpty) {
      _settings = Settings.fromMap(_data[0]);
      _passwordDB = _settings.password;
    }

    if (_settings.salt.isNotEmpty && _settings.iv.isNotEmpty) {
      _settings.salt = _settings.salt;
      _settings.iv = _settings.iv;
    } else {
      _settings.salt = GosutoAes256Gcm.randomBytes(16);
      _settings.iv = GosutoAes256Gcm.randomBytes(12);
    }

    if (_passwordDB != '') {
      hashedPassword = _passwordDB;
    } else {
      Hash hashedPasswordBytes = await Sha1().hash(password.codeUnits);
      hashedPassword = hex.encode(hashedPasswordBytes.bytes);

      // Update password for the first wallet
      await DBHelper().updateSettings(
        Settings(
          password: hashedPassword,
          useBiometricAuth: _settings.useBiometricAuth,
          salt: _settings.salt,
          iv: _settings.iv,
        ),
        'password',
      );
    }

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(privateKey.toHex(), hashedPassword);
    String hashedSeedPhrase =
        await GosutoAes256Gcm.encrypt(seedPhrase, hashedPassword);

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
        seedPhrase: hashedSeedPhrase,
        privateKey: hashedPrivateKey,
      ),
    );

    return walletId;
  }
}
