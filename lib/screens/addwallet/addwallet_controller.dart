import 'package:get/get.dart';

class AddWalletController extends GetxController {
  var methodId = 0.obs;

  void updateAddWalletMethod(var _methodId) {
    methodId.value = _methodId;
  }
}
