import 'dart:typed_data';

import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/utils/utils.dart';

class ImportPkController extends GetxController {
  dynamic data = Get.arguments;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController privateKeyController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  var privateKeyBytes = Uint8List.fromList([]);
  var publicKeyBytes = Uint8List.fromList([]);
  late SignatureAlgorithm? keyType;

  var walletName = ''.obs;
  var privateKey = ''.obs;
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
    privateKeyController = TextEditingController();
    passwordController = TextEditingController();
    password2Controller = TextEditingController();
    getPasswordDB();
    super.onInit();
  }

  @override
  void onClose() {
    walletNameController.dispose();
    privateKeyController.dispose();
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

  String? validatePrivateKey(String value) {
    if (value.isEmpty) {
      return 'private_key_empty'.tr;
    }

    var base64Str = normalizePrivateKey(value);

    if (base64Str.length < 64 || base64Str.length > 226) {
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
        // check wallet exist
        var base64Str = normalizePrivateKey(privateKey.value);
        switch (base64Str.length) {
          case 64:
            privateKeyBytes = Ed25519.readBase64WithPEM(privateKey.value);
            keyType = SignatureAlgorithm.Ed25519;
            break;
          case 160:
            privateKeyBytes = Secp256K1.parsePrivateKey(
                Secp256K1.readBase64WithPEM(privateKey.value));
            keyType = SignatureAlgorithm.Secp256K1;
            break;
          default:
            keyType = null;
        }

        if (keyType == null) {
          errorMessage = 'invalid_private_key'.tr;
          isValid = false;
        } else {
          publicKeyBytes =
              CasperClient.privateToPublicKey(privateKeyBytes, keyType!);
        }

        var wallets =
            await DBHelper().getWalletByPublicKey(base16Encode(publicKeyBytes));
        if (wallets.isNotEmpty) {
          errorMessage = 'wallet_exist'.tr;
          isValid = false;
        }
      }
    }

    map['isValid'] = isValid;
    map['errorMessage'] = errorMessage;
    return map;
  }

  Future<int> createWallet() async {
    return await WalletUtils.importWalletByPrivateKey(
        walletName.value, privateKeyBytes, publicKeyBytes, keyType);
  }
}
