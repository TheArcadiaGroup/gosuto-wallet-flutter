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
import 'package:gosuto/utils/importwallet.dart';
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

  Future<int> createWallet() async {
    return await WalletUtils.importWallet(
      walletName.value,
      seedPhrase.value,
      password.value,
    );
  }
}
