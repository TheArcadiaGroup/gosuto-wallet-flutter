import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:bip39/bip39.dart' as bip39;

class ImportFileController extends GetxController {
  dynamic data = Get.arguments;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController seedPhraseController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  var walletName = ''.obs;
  var privateKey = ''.obs;
  var seedPhrase = ''.obs;
  var password = ''.obs;
  var password2 = ''.obs;
  var fileName = ''.obs;

  var hidePassword = true.obs;
  var hideRePassword = true.obs;
  var agreed = false.obs;

  @override
  void onInit() {
    super.onInit();
    walletNameController = TextEditingController(
        text: 'Gosuto ' + data[0]['walletIndex'].toString());
    seedPhraseController = TextEditingController();
    passwordController = TextEditingController();
    password2Controller = TextEditingController();
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
      String passwordDB = await DBHelper().getPassword();

      if (passwordDB != '' && privateKey.value.length == 64) {
        // check wallet exist
        PrivateKey pk = PrivateKey.fromHex(privateKey.value);
        String publicKey = pk.publicKey.toCompressedHex();
        var wallets = await DBHelper().getWalletByPublicKey(publicKey);
        if (wallets.isNotEmpty) {
          errorMessage = 'wallet_exist'.tr;
          isValid = false;
        }
      }
    }

    if (privateKey.value != '' && privateKey.value.length != 64) {
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
        walletName.value,
        privateKey.value,
      );
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
