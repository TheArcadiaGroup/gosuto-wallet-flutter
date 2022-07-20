import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/utils/utils.dart';

class CreateWalletController extends GetxController {
  dynamic data = Get.arguments;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  var walletName = ''.obs;
  var password = ''.obs;
  var password2 = ''.obs;

  var passwordDB = ''.obs;

  var hidePassword = true.obs;
  var hideRePassword = true.obs;
  var agreed = true.obs; // false.obs;

  @override
  void onInit() {
    walletNameController = TextEditingController(
        text: 'Gosuto ' + data[0]['walletIndex'].toString());
    passwordController = TextEditingController();
    password2Controller = TextEditingController();
    getPasswordDB();
    super.onInit();
  }

  @override
  void onClose() {
    walletNameController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    super.onClose();
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
      return 'wallet_name_empty'.tr;
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'password_empty'.tr;
    }

    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'confirm_password_empty'.tr;
    }

    if (value != password.value) {
      return 'confirm_password_wrong'.tr;
    }

    return null;
  }

  Future<String> getSeedPhrase() async {
    final _settings = await DBHelper().getSettings();

    if (_settings != null) {
      return _settings.seedPhrase;
    }

    return '';
  }

  Future<void> getPasswordDB() async {
    String password = await DBHelper().getPassword();
    passwordDB(password);
  }

  Future<bool> checkValidate() async {
    bool isValid = formKey.currentState!.validate();
    bool walletIsExist = await DBHelper().isWalletNameExist(
        walletName.value.isNotEmpty
            ? walletName.value
            : walletNameController.text);
    isValid = !walletIsExist;
    return isValid;
  }

  Future<int> createWallet() async {
    return await WalletUtils.importWallet(
      walletName.value,
      password.value,
    );
  }
}
