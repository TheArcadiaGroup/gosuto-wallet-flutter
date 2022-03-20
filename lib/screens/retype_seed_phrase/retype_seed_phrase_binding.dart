import 'package:get/instance_manager.dart';
import 'retype_seed_phrase_controller.dart';

class RetypeSeedPhraseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RetypeSeedPhraseController>(() => RetypeSeedPhraseController());
  }
}
