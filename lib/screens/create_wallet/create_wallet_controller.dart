import 'package:get/get.dart';

class CreateWalletController extends GetxController {
  var hidePassword = true.obs;
  var hideRePassword = true.obs;

  void togglePassword() {
    hidePassword.value = !hidePassword.value;
  }

  void toggleRePassword() {
    hideRePassword.value = !hideRePassword.value;
  }
}