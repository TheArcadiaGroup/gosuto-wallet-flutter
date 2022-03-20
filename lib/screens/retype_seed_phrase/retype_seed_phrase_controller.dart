import 'package:get/get.dart';

class RetypeSeedPhraseController extends GetxController {
  var seedPhrase = ''.obs;
  dynamic data = Get.arguments;

  @override
  void onInit() {
    seedPhrase.value = data[0]['seed_phrase'];
    super.onInit();
  }
}
