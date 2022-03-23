import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateWalletController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  var walletName = ''.obs;
  var password = ''.obs;
  var password2 = ''.obs;

  var hidePassword = true.obs;
  var hideRePassword = true.obs;
  var agreed = false.obs;

  @override
  void onInit() {
    super.onInit();
    walletNameController = TextEditingController();
    passwordController = TextEditingController();
    password2Controller = TextEditingController();
  }

  @override
  void onClose() {
    walletNameController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
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

  String? validateWalletName(String value) {
    if (value.isEmpty) {
      return 'Please enter wallet name';
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }

    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please enter confirm password';
    }

    if (value != password.value) {
      return 'Confirm password does not match';
    }

    return null;
  }

  void checkValidate() {
    final isValid = formKey.currentState!.validate();

    if (isValid && agreed.value) {
      formKey.currentState!.save();
      Get.toNamed('/seed_phrase', arguments: [
        {'walletName': walletName.value},
        {'password': password.value},
      ]);
    }
  }
}
