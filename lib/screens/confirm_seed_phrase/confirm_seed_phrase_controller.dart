import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/wallet.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:convert/convert.dart';

import '../../utils/crypto.dart';

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

  void generateWallet() async {
    Uint8List seed = bip39.mnemonicToSeed(seedPhraseToCompare.value);
    String seedHex = hex.encode(Uint8List.fromList(seed.sublist(0, 32)));
    final privateKey = PrivateKey.fromHex(seedHex);
    final publicKey = privateKey.publicKey;
    String hashedPassword = await GosutoEncode().hashPassword(password.value);
    String walletKey = privateKey.toHex() + hashedPassword;

    final algorithm = AesCbc.with256bits(macAlgorithm: Hmac.sha256());
    final secretKey = await algorithm.newSecretKey();
    final nonce = algorithm.newNonce();

    String cipherText =
        await GosutoEncode().encodeWallet(walletKey, secretKey, nonce);

    int id = await DBHelper().insertWallet(Wallet.fromMap({
      'walletName': walletName.value,
      'publicKey': publicKey.toCompressedHex(),
      'cipherText': cipherText,
      'secretKey': await secretKey.extractBytes(),
      'nonce': nonce,
    }));

    print(id.toString());

    // List<int> decryptData = await GosutoEncode().decodeWallet(
    //   walletKey,
    //   password.value,
    //   secretKey,
    //   nonce,
    // );

    // Uint8List decodedPk = Uint8List.fromList(decryptData.sublist(0, 128));
    // Uint8List decodedPassword =
    //     Uint8List.fromList(decryptData.sublist(128, decryptData.length));

    // print('PK: ' + privateKey.toHex());
    // print('Hashed PK: ' + hashedPrivateKey.length.toString());
    // print('walletKey: $walletKey');
    // print(String.fromCharCodes(decodedPk));
    // print('hashed password: ' + hashedPassword);
    // print('password: ' + String.fromCharCodes(decodedPassword));
  }
}
