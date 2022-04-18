import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/utils/utils.dart';

class ImportPkController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController privateKeyController;

  var walletName = ''.obs;
  var privateKey = ''.obs;

  var hidePassword = true.obs;
  var hideRePassword = true.obs;
  var agreed = false.obs;

  @override
  void onInit() {
    super.onInit();
    walletNameController = TextEditingController();
    privateKeyController = TextEditingController();
  }

  @override
  void onClose() {
    walletNameController.dispose();
    privateKeyController.dispose();
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

    if (value.length != 64) {
      return 'invalid_private_key'.tr;
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'password_empty'.tr;
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
      isValid = false;
    } else {
      // check seed phrase exist
      String password = await DBHelper().getPassword();

      if (password != '') {
        String hashedPrivateKey =
            await GosutoAes256Gcm.encrypt(privateKey.value, password);

        // check seed phrase exist
        var wallets = await DBHelper().getWalletByPrivateKey(hashedPrivateKey);
        if (wallets.isNotEmpty) {
          errorMessage = 'wallet_exist'.tr;
          isValid = false;
        }
      }
    }

    if (privateKey.value.length != 64) {
      errorMessage = 'invalid_private_key'.tr;
      isValid = false;
    }

    map['isValid'] = isValid;
    map['errorMessage'] = errorMessage;
    return map;
  }

  Future<int> createWallet() async {
    return 0;
    // await WalletUtils.importWallet(
    //   walletName.value,
    //   password.value,
    //   seedPhrase.value,
    // );
  }
}
