import 'package:get/instance_manager.dart';
import 'package:gosuto/screens/addwallet/addwallet_controller.dart';

class AddWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWalletController>(() => AddWalletController());
  }
}
