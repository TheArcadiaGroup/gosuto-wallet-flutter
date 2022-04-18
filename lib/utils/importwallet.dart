import 'dart:typed_data';

import 'package:blake2b/blake2b_hash.dart';
import 'package:cryptography/cryptography.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/settings.dart';
import 'package:gosuto/models/wallet.dart';
import 'package:gosuto/utils/casper_hdkey.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:convert/convert.dart';
import 'package:hdkey/hdkey.dart';
import 'package:secp256k1/secp256k1.dart';

class WalletUtils {
  static Future<int> importWallet(String walletName,
      [String password = '', String seedPhrase = '']) async {
    String passwordDB = '';
    String hashedPassword = '';

    String seedPhraseDB = '';
    String hashedSeedPhrase = '';

    Settings _settings = Settings(
      seedPhrase: '',
      password: '',
      useBiometricAuth: 0,
    );

    // Get settings from db
    var _data = await DBHelper().getSettings();
    if (_data.isNotEmpty) {
      _settings = Settings.fromMap(_data[0]);
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
    if (passwordDB == '' && seedPhraseDB == '') {
      if (password != '') {
        Hash hashedPasswordBytes = await Sha1().hash(password.codeUnits);
        hashedPassword = hex.encode(hashedPasswordBytes.bytes);
      }

      if (seedPhrase != '') {
        hashedSeedPhrase =
            await GosutoAes256Gcm.encrypt(seedPhrase, hashedPassword);
      }

      await DBHelper().updateSettings(
        Settings(
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
    int walletIndex = await DBHelper().getTheLastestWalletId();

    HDKey hdKey = HDKey.fromMnemonic(decryptedSeedPhrase);
    CasperHDKey cHDkey = CasperHDKey(hdKey);
    HDKey childKey = cHDkey.deriveIndex(walletIndex);
    String privateKey = hex.encode(childKey.privateKey!.toList());
    String publicKey = hex.encode(childKey.publicKey!.toList());

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(privateKey, passwordDB);

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

  static Future<int> importWalletByPrivateKey(
      String walletName, String privateKey) async {
    String passwordDB = '';

    Settings _settings = Settings(
      seedPhrase: '',
      password: '',
      useBiometricAuth: 0,
    );

    // Get settings from db
    var _data = await DBHelper().getSettings();
    if (_data.isNotEmpty) {
      _settings = Settings.fromMap(_data[0]);
      passwordDB = _settings.password;
    }

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(privateKey, passwordDB);

    PrivateKey pk = PrivateKey.fromHex(privateKey);
    String publicKey = pk.publicKey.toCompressedHex();
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
