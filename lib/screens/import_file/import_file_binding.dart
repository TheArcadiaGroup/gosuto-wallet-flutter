import 'package:get/instance_manager.dart';
import 'import_file_controller.dart';

class ImportFileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImportFileController>(() => ImportFileController());
  }
}
