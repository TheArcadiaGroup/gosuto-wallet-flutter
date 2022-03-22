import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:secp256k1/secp256k1.dart';
import 'package:convert/convert.dart';

import '../../utils/encode.dart';

class ConfirmSeedPhraseController extends GetxController {
  dynamic data = Get.arguments;

  var seedPhrase = ''.obs;
  var password = ''.obs;
  var seedPhraseToCompare = ''.obs;
  var word1 = ''.obs;
  var word2 = ''.obs;
  var word3 = ''.obs;
  var listOfIndexes = [].obs;
  Random random = Random();

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

  void generateWallet() async {
    Uint8List seed = bip39.mnemonicToSeed(seedPhraseToCompare.value);
    String seedHex = hex.encode(Uint8List.fromList(seed.sublist(0, 32)));
    var privateKey = PrivateKey.fromHex(seedHex);
    var publicKey = privateKey.publicKey;

    final algorithm = AesCbc.with256bits(macAlgorithm: Hmac.sha256());
    SecretKey secretKey = await algorithm.newSecretKey();
    final nonce = algorithm.newNonce();

    GosutoEncode().encodeWallet(privateKey, password.value, secretKey, nonce);

    List<int> decryptData = await GosutoEncode().decodeWallet(
      privateKey.toHex() + password.value,
      password.value,
      secretKey,
      nonce,
    );

    Uint8List decodedPk = Uint8List.fromList(decryptData.sublist(0, 64));
    Uint8List decodedPassword =
        Uint8List.fromList(decryptData.sublist(64, decryptData.length));

    print(String.fromCharCodes(decodedPk));
    print('password: ' + String.fromCharCodes(decodedPassword));
  }

  @override
  void onInit() {
    super.onInit();

    Set<int> setOfIndexes = {};
    while (setOfIndexes.length < 3) {
      setOfIndexes.add(random.nextInt(12));
    }

    listOfIndexes = setOfIndexes.toList().obs;
    listOfIndexes.sort();

    seedPhrase.value = data[0]['seed_phrase'];
    password.value = data[1]['password'];
  }
}
