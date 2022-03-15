import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;

class SeedPhraseController extends GetxController {
  var seedPhrase = ''.obs;

  void _generateSeedPhrase() {
    seedPhrase.value = bip39.generateMnemonic();
  }

  @override
  void onInit() {
    super.onInit();
    _generateSeedPhrase();
  }
}
