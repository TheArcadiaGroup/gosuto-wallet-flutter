import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateWalletController extends GetxController {
  var walletName = ''.obs;
  var hidePassword = true.obs;
  var hideRePassword = true.obs;
  var agreed = false.obs;
  late TextEditingController walletNameController;

  @override
  void onInit() {
    super.onInit();
    walletNameController = TextEditingController();
  }

  void togglePassword() {
    hidePassword.value = !hidePassword.value;
  }

  void toggleRePassword() {
    hideRePassword.value = !hideRePassword.value;
  }

  void toggleAgreed() {
    agreed.value = !agreed.value;
  }
}
