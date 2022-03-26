import 'package:get/instance_manager.dart';
import 'import_seed_controller.dart';

class ImportSeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImportSeedController>(() => ImportSeedController());
  }
}
