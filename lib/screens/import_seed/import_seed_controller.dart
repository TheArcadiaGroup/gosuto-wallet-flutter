import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/utils/utils.dart';

class ImportSeedController extends GetxController {
  dynamic data = Get.arguments;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController seedPhraseController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  var walletName = ''.obs;
  var seedPhrase = ''.obs;
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
    seedPhraseController = TextEditingController();
    passwordController = TextEditingController();
    password2Controller = TextEditingController();
    getPasswordDB();
    super.onInit();
  }

  @override
  void onClose() {
    walletNameController.dispose();
    seedPhraseController.dispose();
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

  Future<void> getPasswordDB() async {
    String password = await DBHelper().getPassword();
    passwordDB(password);
  }

  Future<Map> checkValidate() async {
    bool isValid = formKey.currentState!.validate();
    bool walletNameIsExist =
        await DBHelper().isWalletNameExist(walletName.value);

    String errorMessage = '';
    var map = {};

    if (walletNameIsExist) {
      errorMessage = 'wallet_name_exist'.tr;
      isValid = false;
    } else {
      // check seed phrase exist
      String password = await DBHelper().getPassword();

      if (password != '') {
        String hashedSeedPhrase =
            await GosutoAes256Gcm.encrypt(seedPhrase.value, password);

        // check seed phrase exist
        var wallets = await DBHelper().getWalletsBySeedPhrase(hashedSeedPhrase);
        if (wallets.isNotEmpty) {
          errorMessage = 'seed_phrase_exist'.tr;
          isValid = false;
        }
      }
    }

    if (!bip39.validateMnemonic(seedPhrase.value)) {
      errorMessage = 'seed_phrase_invalid'.tr;
      isValid = false;
    }

    map['isValid'] = isValid;
    map['errorMessage'] = errorMessage;
    return map;
  }

  Future<int> createWallet() async {
    return await WalletUtils.importWallet(
      walletName.value,
      password.value,
      seedPhrase.value,
    );
  }
}
