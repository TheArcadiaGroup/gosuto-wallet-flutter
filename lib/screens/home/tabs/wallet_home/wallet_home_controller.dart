import 'package:carousel_slider/carousel_controller.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/data/network/api_client.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/env/env.dart';
import 'package:gosuto/models/settings.dart';
import 'package:convert/convert.dart';

import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import 'wallet_home.dart';

class WalletHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late CarouselController carouselController;
  late ApiClient apiClient;

  var currentTab = WalletHomeTabs.history.obs;
  var isShowBottom = false.obs;
  var walletName = ''.obs;
  var currentPass = ''.obs;
  var newPass = ''.obs;
  var rePass = ''.obs;
  var pass = ''.obs;
  var page = 1.obs;
  var limit = 10.obs;

  RxList<TransferModel> transfers = RxList<TransferModel>();
  RxList<String> seedPhrases = RxList<String>();
  Rx<Settings>? setting;
  Rx<TransferModel>? selectedTransfer;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 5, vsync: this);
    carouselController = CarouselController();

    apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');
    // TODO: Fake
    // accountHash = '35305979df049640142981a6f3765519dfd032066a5cb932c674bb56f2044b5b'
    // page=1&limit=10&order_direction=DESC&with_extended_info=1
    getTransfers(
        '35305979df049640142981a6f3765519dfd032066a5cb932c674bb56f2044b5b',
        page.value,
        limit.value,
        'DESC',
        1);
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  WalletHomeTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return WalletHomeTabs.history;
      case 1:
        return WalletHomeTabs.send;
      case 2:
        return WalletHomeTabs.stake;
      case 3:
        return WalletHomeTabs.walletSettings;
      case 4:
        return WalletHomeTabs.swap;
      default:
        return WalletHomeTabs.history;
    }
  }

  Future updateWallet(Wallet wallet) async {
    await DBHelper().update(wallet);
  }

  Future<void> getTransfers(String accountHash, int page, int limit,
      String orderDirection, int withExtendedInfo) async {
    final response = await apiClient.accountsTransfers(
        accountHash, page, limit, orderDirection, withExtendedInfo);
    List<dynamic> data = response.data;
    final _transfers = data.map((val) => TransferModel.fromJson(val)).toList();
    if (transfers.isEmpty) {
      transfers(_transfers);
    } else {
      transfers.addAll(_transfers);
    }
  }

  Future<void> getSeedPhrase() async {
    String decryptedSeedPhrase = await GosutoAes256Gcm.decrypt(
        setting?.value.seedPhrase ?? '', setting?.value.password ?? '');
    List<String> _seedPhrases = decryptedSeedPhrase.split(' ');
    seedPhrases(_seedPhrases);
  }

  Future<bool> checkPass(String pass) async {
    Hash hashedPasswordBytes = await Sha1().hash(pass.codeUnits);
    String hashedPassword = hex.encode(hashedPasswordBytes.bytes);
    return hashedPassword == setting?.value.password;
  }

  Future<void> updatePassword() async {
    Hash hashedPasswordBytes = await Sha1().hash(newPass.value.codeUnits);
    String hashedPassword = hex.encode(hashedPasswordBytes.bytes);
    setting?.value.password = hashedPassword;
    setting?.refresh();

    await DBHelper().updateSettings(
      setting!.value,
      'password',
    );

    newPass('');
    currentPass('');
    rePass('');
  }
}
