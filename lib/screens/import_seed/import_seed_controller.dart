import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;

import '../../database/dbhelper.dart';
import '../../utils/aes256gcm.dart';

class ImportSeedController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController seedPhraseController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  var walletName = ''.obs;
  var seedPhrase = ''.obs;
  var password = ''.obs;
  var password2 = ''.obs;

  var hidePassword = true.obs;
  var hideRePassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    walletNameController = TextEditingController();
    seedPhraseController = TextEditingController();
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

  String? validateWalletName(String value) {
    if (value.isEmpty) {
      return 'wallet_name_empty'.tr;
    }

    return null;
  }

  String? validateSeedPhrase(String value) {
    if (value.isEmpty) {
      return 'seed_phrase_empty'.tr;
    }

    if (!bip39.validateMnemonic(value)) {
      return 'seed_phrase_invalid'.tr;
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

  Future<Map> checkValidate() async {
    bool isValid = formKey.currentState!.validate();
    bool walletNameIsExist =
        await DBHelper().isWalletNameExist(walletName.value);

    String errorMessage = '';
    var map = {};

    if (walletNameIsExist) {
      errorMessage = 'wallet_name_exist'.tr;
    } else {
      errorMessage = 'seed_phrase_exist'.tr;
    }
    isValid = !walletNameIsExist;

    map['isValid'] = isValid;
    map['errorMessage'] = errorMessage;
    return map;
  }
}
