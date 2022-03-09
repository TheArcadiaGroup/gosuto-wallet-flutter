import 'package:get/get.dart';

import 'wallet_home_controller.dart';

class WalletHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletHomeController>(() => WalletHomeController());
  }
}