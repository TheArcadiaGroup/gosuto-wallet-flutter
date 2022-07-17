import 'dart:typed_data';

import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:gosuto/utils/utils.dart';

class ImportFileController extends GetxController {
  dynamic data = Get.arguments;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController seedPhraseController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  var privateKeyBytes = Uint8List.fromList([]);
  var publicKeyBytes = Uint8List.fromList([]);
  late SignatureAlgorithm? keyType;

  var walletName = ''.obs;
  var privateKey = ''.obs;
  var seedPhrase = ''.obs;
  var password = ''.obs;
  var password2 = ''.obs;

  var passwordDB = ''.obs;

  var fileName = ''.obs;

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
      if (passwordDB.value != '') {
        // check wallet exist
        var base64Str = normalizePrivateKey(privateKey.value);
        switch (base64Str.length) {
          case 64:
            privateKeyBytes = Ed25519.readBase64WithPEM(privateKey.value);
            keyType = SignatureAlgorithm.Ed25519;
            break;
          case 160:
            privateKeyBytes = Secp256K1.readBase64WithPEM(privateKey.value);
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

    if (privateKey.value != '' &&
        (privateKey.value.length < 64 || privateKey.value.length > 226)) {
      errorMessage = 'private_key_invalid'.tr;
      isValid = false;
    }

    if (seedPhrase.value != '' && !bip39.validateMnemonic(seedPhrase.value)) {
      errorMessage = 'seed_phrase_invalid'.tr;
      isValid = false;
    }

    map['isValid'] = isValid;
    map['errorMessage'] = errorMessage;
    return map;
  }

  Future<int> createWallet() async {
    int walletId = 0;
    bool seedPhraseAdded = await DBHelper().isSeedPhraseAdded();

    if (seedPhraseAdded) {
      walletId = await WalletUtils.importWalletByPrivateKey(
          walletName.value, privateKeyBytes, publicKeyBytes, keyType);
    } else {
      walletId = await WalletUtils.importWallet(
        walletName.value,
        password.value,
        seedPhrase.value,
      );
    }

    return walletId;
  }
}
