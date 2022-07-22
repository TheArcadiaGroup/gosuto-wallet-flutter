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
      seedPhrase: '',
      password: '',
      useBiometricAuth: 0,
    );

    // Get settings from db
    var settingsDB = await DBHelper.getSettings();
    if (settingsDB != null) {
      passwordDB = settingsDB.password;
      seedPhraseDB = settingsDB.seedPhrase;
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

      await DBHelper.updateSettings(
        SettingsModel(
          seedPhrase: hashedSeedPhrase,
          password: hashedPassword,
          useBiometricAuth: _settings.useBiometricAuth,
        ),
        'all',
      );

      passwordDB = hashedPassword;
      seedPhraseDB = hashedSeedPhrase;
    }

    String decryptedSeedPhrase =
        await GosutoAes256Gcm.decrypt(seedPhraseDB, passwordDB);

    // Get current index
    int walletIndex = await DBHelper.getTheLastestWalletId();

    var casperHDKey = CasperHDKey.fromMasterSeed(
        Uint8List.fromList(decryptedSeedPhrase.codeUnits.toList()));
    var key = casperHDKey.deriveIndex(walletIndex);

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(base16Encode(key.privateKey), passwordDB);
    String accountHash = key.publicKey.toAccountHashStr();
    bool isValidator = await AccountUtils.isValidator(
        accountHash.replaceAll('account-hash-', ''));

    int walletId = await DBHelper.insertWallet(
      WalletModel(
          name: walletName,
          publicKey: key.publicKey.toHex(),
          accountHash: accountHash,
          privateKey: hashedPrivateKey,
          isValidator: isValidator),
    );

    return walletId;
  }

  static Future<int> importWalletByPrivateKey(
      String walletName, Uint8List privateKey, Uint8List publicKey,
      [SignatureAlgorithm? algo, String password = '']) async {
    String passwordDB = '';
    String hashedPassword = '';

    SettingsModel _settings = SettingsModel(
      seedPhrase: '',
      password: '',
      useBiometricAuth: 0,
    );

    // Get settings from db
    var settingsDB = await DBHelper.getSettings();
    if (settingsDB != null) {
      passwordDB = settingsDB.password;
    }

    if (passwordDB != '') {
      hashedPassword = passwordDB;
    } else {
      // Add password & seed phrase for the first time
      if (password != '') {
        var hashedPasswordBytes =
            await cryptography.Sha1().hash(password.codeUnits);

        hashedPassword = hex.encode(hashedPasswordBytes.bytes);

        await DBHelper.updateSettings(
          SettingsModel(
            seedPhrase: '',
            password: hashedPassword,
            useBiometricAuth: _settings.useBiometricAuth,
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

      String accountHash = clPublicKey.toAccountHashStr();
      bool isValidator = await AccountUtils.isValidator(
          accountHash.replaceAll('account-hash-', ''));

      int walletId = await DBHelper.insertWallet(
        WalletModel(
            name: walletName,
            publicKey: clPublicKey.toHex(),
            accountHash: accountHash,
            privateKey: hashedPrivateKey,
            isValidator: isValidator),
      );
      return walletId;
    }

    return 0;
  }
}
