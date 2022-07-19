import 'dart:typed_data';

import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:cryptography/cryptography.dart' as cryptography;
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/models.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:convert/convert.dart';

class WalletUtils {
  static Future<int> importWallet(String walletName,
      [String password = '', String seedPhrase = '']) async {
    String passwordDB = '';
    String hashedPassword = '';

    String seedPhraseDB = '';
    String hashedSeedPhrase = '';

    SettingsModel _settings = SettingsModel(
      '',
      '',
      0,
    );

    // Get settings from db
    var _data = await DBHelper().getSettings();
    if (_data.isNotEmpty) {
      _settings = SettingsModel.fromJson(_data[0]);
      passwordDB = _settings.password;
      seedPhraseDB = _settings.seedPhrase;
    }

    if (passwordDB != '') {
      hashedPassword = passwordDB;
    }

    if (seedPhraseDB != '') {
      hashedSeedPhrase = seedPhraseDB;
    }

    // Add password & seed phrase for the first time
    if (passwordDB == '' || seedPhraseDB == '') {
      if (password != '') {
        var hashedPasswordBytes =
            await cryptography.Sha1().hash(password.codeUnits);
        hashedPassword = hex.encode(hashedPasswordBytes.bytes);
      }

      if (seedPhrase != '') {
        hashedSeedPhrase =
            await GosutoAes256Gcm.encrypt(seedPhrase, hashedPassword);
      }

      await DBHelper().updateSettings(
        SettingsModel(
          hashedSeedPhrase,
          hashedPassword,
          _settings.useBiometricAuth,
        ),
        'all',
      );

      passwordDB = hashedPassword;
      seedPhraseDB = hashedSeedPhrase;
    }

    String decryptedSeedPhrase =
        await GosutoAes256Gcm.decrypt(seedPhraseDB, passwordDB);

    // Get current index
    int walletIndex = await DBHelper().getTheLastestWalletId();

    var casperHDKey = CasperHDKey.fromMasterSeed(
        Uint8List.fromList(decryptedSeedPhrase.codeUnits.toList()));
    var key = casperHDKey.deriveIndex(walletIndex);

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(base16Encode(key.privateKey), passwordDB);
    int walletId = await DBHelper().insertWallet(
      WalletModel(walletName, key.publicKey.toHex(),
          key.publicKey.toAccountHashStr(), hashedPrivateKey, 0),
    );

    return walletId;
  }

  static Future<int> importWalletByPrivateKey(
      String walletName, Uint8List privateKey, Uint8List publicKey,
      [SignatureAlgorithm? algo, String password = '']) async {
    String passwordDB = '';
    String hashedPassword = '';

    SettingsModel _settings = SettingsModel(
      '',
      '',
      0,
    );

    // Get settings from db
    var _data = await DBHelper().getSettings();
    if (_data.isNotEmpty) {
      _settings = SettingsModel.fromJson(_data[0]);
      passwordDB = _settings.password;
    }

    if (passwordDB != '') {
      hashedPassword = passwordDB;
    } else {
      // Add password & seed phrase for the first time
      if (password != '') {
        var hashedPasswordBytes =
            await cryptography.Sha1().hash(password.codeUnits);

        hashedPassword = hex.encode(hashedPasswordBytes.bytes);

        await DBHelper().updateSettings(
          SettingsModel(
            '',
            hashedPassword,
            _settings.useBiometricAuth,
          ),
          'password',
        );

        passwordDB = hashedPassword;
      }
    }

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(base16Encode(privateKey), passwordDB);
    if (algo != null) {
      CLPublicKey clPublicKey;
      if (algo == SignatureAlgorithm.Ed25519) {
        clPublicKey = CLPublicKey.fromEd25519(publicKey);
      } else {
        clPublicKey = CLPublicKey.fromSecp256K1(publicKey);
      }

      int walletId = await DBHelper().insertWallet(
        WalletModel(walletName, clPublicKey.toHex(),
            clPublicKey.toAccountHashStr(), hashedPrivateKey, 0),
      );
      return walletId;
    }

    return 0;
  }
}
