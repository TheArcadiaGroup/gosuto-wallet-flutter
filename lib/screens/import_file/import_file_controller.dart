import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/settings.dart';
import 'package:gosuto/utils/utils.dart';

class ImportFileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController walletNameController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;

  var walletName = ''.obs;
  var privateKey = ''.obs;
  var password = ''.obs;
  var password2 = ''.obs;
  var fileName = ''.obs;

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

  Future<String> getPassword() async {
    final _data = await DBHelper().getSettings();

    if (_data.isNotEmpty) {
      Settings _settings = Settings.fromMap(_data[0]);
      return _settings.password;
    }

    return '';
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
      String password = await getPassword();

      if (password != '') {
        String hashedPrivateKey =
            await GosutoAes256Gcm.encrypt(privateKey.value, password);

        // check seed phrase exist
        var wallets = await DBHelper().getWalletByPrivateKey(hashedPrivateKey);
        // print(wallets[0]);
        if (wallets.isNotEmpty) {
          errorMessage = 'private_key_exist'.tr;
          isValid = false;
        }
      }
    }

    if (privateKey.value.length != 64) {
      errorMessage = 'private_key_invalid'.tr;
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
      '',
      privateKey.value,
    );
  }
}
