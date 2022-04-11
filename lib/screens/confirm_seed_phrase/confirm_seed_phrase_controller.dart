import 'dart:math';
import 'dart:typed_data';

import 'package:blake2b/blake2b_hash.dart';
import 'package:cryptography/cryptography.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/settings.dart';
import 'package:gosuto/models/wallet.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:convert/convert.dart';

import '../../utils/aes256gcm.dart';

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
    Uint8List seed = bip39.mnemonicToSeed(seedPhrase.value);
    String seedHex = hex.encode(Uint8List.fromList(seed.sublist(0, 32)));
    PrivateKey privateKey = PrivateKey.fromHex(seedHex);
    String publicKey = privateKey.publicKey.toCompressedHex();
    String hashedPassword;
    String _passwordDB = '';

    // Get password from db
    final _data = await DBHelper().getSettings();

    if (_data.isNotEmpty) {
      Settings _settings = Settings.fromMap(_data[0]);
      _passwordDB = _settings.password ?? '';
    }

    if (_passwordDB != '') {
      hashedPassword = _passwordDB;
    } else {
      Hash hashedPasswordBytes = await Sha1().hash(password.value.codeUnits);
      hashedPassword = hex.encode(hashedPasswordBytes.bytes);
    }

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(privateKey.toHex(), hashedPassword);
    String hashedSeedPhrase =
        await GosutoAes256Gcm.encrypt(seedHex, hashedPassword);

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

    // Update password for settings
    await DBHelper().updateSettings(Settings(password: hashedPassword));

    return walletId;
  }
}
