import 'dart:math';
import 'dart:typed_data';

import 'package:blake2b/blake2b_hash.dart';
import 'package:cryptography/cryptography.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/settings.dart';
import 'package:gosuto/models/wallet.dart';
import 'package:gosuto/utils/aes256gcm.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:convert/convert.dart';

class ConfirmSeedPhraseController extends GetxController {
  dynamic data = Get.arguments;

  var seedPhrase = ''.obs;
  var walletName = ''.obs;
  var password = ''.obs;
  var seedPhraseToCompare = ''.obs;
  var word1 = ''.obs;
  var word2 = ''.obs;
  var word3 = ''.obs;
  var listOfIndexes = [].obs;
  Random random = Random();

  @override
  void onInit() {
    super.onInit();

    Set<int> setOfIndexes = {};
    while (setOfIndexes.length < 3) {
      setOfIndexes.add(random.nextInt(12));
    }

    listOfIndexes = setOfIndexes.toList().obs;
    listOfIndexes.sort();

    walletName.value = data[0]['walletName'];
    seedPhrase.value = data[1]['seedPhrase'];
    password.value = data[2]['password'];
  }

  List<String> getListOfWords() {
    List<String> words = seedPhrase.split(' ');

    return List.generate(12, (index) {
      if (index == listOfIndexes[0]) {
        return word1.value;
      }

      if (index == listOfIndexes[1]) {
        return word2.value;
      }

      if (index == listOfIndexes[2]) {
        return word3.value;
      }

      return words[index];
    }, growable: false);
  }

  Future<int> generateWallet() async {
    String seedHex = bip39.mnemonicToSeedHex(seedPhrase.value).substring(0, 64);
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
      Hash hashedPasswordBytes = await Sha1().hash(password.value.codeUnits);
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
        await GosutoAes256Gcm.encrypt(seedPhrase.value, hashedPassword);

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
        walletName: walletName.value,
        publicKey: publicKey,
        accountHash: accountHash,
        seedPhrase: hashedSeedPhrase,
        privateKey: hashedPrivateKey,
      ),
    );

    return walletId;
  }
}
