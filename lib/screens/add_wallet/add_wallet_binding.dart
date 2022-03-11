import 'package:get/instance_manager.dart';
import 'add_wallet_controller.dart';

class AddWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWalletController>(() => AddWalletController());
  }
}
