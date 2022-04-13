import 'dart:math';
import 'package:gosuto/utils/importwallet.dart';
import 'package:get/get.dart';

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
