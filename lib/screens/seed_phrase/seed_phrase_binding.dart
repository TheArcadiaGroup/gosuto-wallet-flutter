import 'package:get/instance_manager.dart';
import 'seed_phrase_controller.dart';

class SeedPhraseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeedPhraseController>(() => SeedPhraseController());
  }
}
