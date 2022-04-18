import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/settings.dart';
import 'package:gosuto/utils/utils.dart';

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
    final _data = await DBHelper().getSettings();

    if (_data.isNotEmpty) {
      Settings _settings = Settings.fromMap(_data[0]);
      return _settings.seedPhrase;
    }

    return '';
  }

  Future<bool> checkValidate() async {
    bool isValid = formKey.currentState!.validate();
    bool walletIsExist = await DBHelper().isWalletNameExist(walletName.value);
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
