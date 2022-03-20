import 'dart:math';

import 'package:get/get.dart';

class ConfirmSeedPhraseController extends GetxController {
  dynamic data = Get.arguments;

  var seedPhrase = ''.obs;
  var seedPhraseToCompare = ''.obs;
  var word1 = ''.obs;
  var word2 = ''.obs;
  var word3 = ''.obs;
  var listOfIndexes = [].obs;
  Random random = Random();

  @override
  void onInit() {
    seedPhrase.value = data[0]['seed_phrase'];

    Set<int> setOfIndexes = {};
    while (setOfIndexes.length < 3) {
      setOfIndexes.add(random.nextInt(12));
    }

    listOfIndexes = setOfIndexes.toList().obs;
    listOfIndexes.sort();
    super.onInit();
  }
}
