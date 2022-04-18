import 'package:get/instance_manager.dart';
import 'import_pk_controller.dart';

class ImportPkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ImportPkController());
  }
}
