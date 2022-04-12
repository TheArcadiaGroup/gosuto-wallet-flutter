import 'dart:typed_data';

import 'package:blake2b/blake2b_hash.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/settings.dart';
import 'package:gosuto/utils/aes256gcm.dart';
import 'package:convert/convert.dart';
import 'package:secp256k1/secp256k1.dart';

import '../../models/wallet.dart';

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
  var agreed = false.obs;

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

  Future<int> importWallet() async {
    String seedHex = bip39.mnemonicToSeedHex(seedPhrase.value).substring(0, 64);
    PrivateKey privateKey = PrivateKey.fromHex(seedHex);
    String publicKey = privateKey.publicKey.toCompressedHex();
    String hashedPassword;
    String _passwordDB = '';
    Settings _settings = Settings(
      password: '',
      useBiometricAuth: 0,
      salt: Uint8List(0),
      iv: Uint8List(0),
    );

    // Get password from db
    var _data = await DBHelper().getSettings();

    if (_data.isNotEmpty) {
      _settings = Settings.fromMap(_data[0]);
      _passwordDB = _settings.password;
    }

    if (_settings.salt.isNotEmpty && _settings.iv.isNotEmpty) {
      _settings.salt = _settings.salt;
      _settings.iv = _settings.iv;
    } else {
      _settings.salt = GosutoAes256Gcm.randomBytes(16);
      _settings.iv = GosutoAes256Gcm.randomBytes(12);
    }

    if (_passwordDB != '') {
      hashedPassword = _passwordDB;
    } else {
      Hash hashedPasswordBytes = await Sha1().hash(password.value.codeUnits);
      hashedPassword = hex.encode(hashedPasswordBytes.bytes);

      // Update password for the first wallet
      await DBHelper().updateSettings(
        Settings(
          password: hashedPassword,
          useBiometricAuth: _settings.useBiometricAuth,
          salt: _settings.salt,
          iv: _settings.iv,
        ),
        'password',
      );
    }

    String hashedPrivateKey =
        await GosutoAes256Gcm.encrypt(privateKey.toHex(), hashedPassword);
    String hashedSeedPhrase =
        await GosutoAes256Gcm.encrypt(seedPhrase.value, hashedPassword);

    // Decrypt wallet
    // var decrypted = await GosutoAes256Gcm.decrypt(cipherText, hasedPassword);

    List<int> signature = 'secp256k1'.codeUnits;
    List<int> bytes = [...signature, 0, ...hex.decode(publicKey)];

    // Calculate Account Hash
    Uint8List hashedBytes =
        Blake2bHash.hash(Uint8List.fromList(bytes), 0, bytes.length);
    String accountHash = hex.encode(hashedBytes);

    int walletId = await DBHelper().insertWallet(
      Wallet(
        walletName: walletName.value,
        publicKey: publicKey,
        accountHash: accountHash,
        seedPhrase: hashedSeedPhrase,
        privateKey: hashedPrivateKey,
      ),
    );

    return walletId;
  }
}
