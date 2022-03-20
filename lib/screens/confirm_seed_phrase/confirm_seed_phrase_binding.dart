import 'package:get/instance_manager.dart';
import 'confirm_seed_phrase_controller.dart';

class ConfirmSeedPhraseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmSeedPhraseController>(
        () => ConfirmSeedPhraseController());
  }
}
