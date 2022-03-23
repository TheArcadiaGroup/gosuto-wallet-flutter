import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;

class SeedPhraseController extends GetxController {
  dynamic data = Get.arguments;

  var seedPhrase = ''.obs;
  var walletName = ''.obs;
  var password = ''.obs;
  var copied = false.obs;

  void _generateSeedPhrase() {
    seedPhrase.value = bip39.generateMnemonic();
  }

  @override
  void onInit() {
    super.onInit();
    _generateSeedPhrase();

    walletName.value = data[0]['walletName'];
    password.value = data[1]['password'];
  }
}
