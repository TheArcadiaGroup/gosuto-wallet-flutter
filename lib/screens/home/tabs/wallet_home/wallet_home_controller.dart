import 'package:carousel_slider/carousel_controller.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/data/network/api_client.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/env/env.dart';
import 'package:gosuto/models/models.dart';
import 'package:convert/convert.dart';
import 'package:gosuto/utils/aes256gcm.dart';

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
  var currentPage = 1.obs;
  var pageCount = 1.obs;
  var itemCount = 0.obs;

  RxList<TransferModel> transfers = RxList<TransferModel>();
  RxList<String> seedPhrases = RxList<String>();
  Rx<SettingsModel>? setting;
  Rx<TransferModel>? selectedTransfer;
  Rx<DeployModel>? selectedDeloy;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 5, vsync: this);
    carouselController = CarouselController();

    apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');
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

  Future updateWallet(WalletModel wallet) async {
    await DBHelper.updateWallet(publicKey: wallet.publicKey);
  }

  Future<void> getTransfers(
    String accountHash, [
    int page = 1,
    int limit = 10,
    String orderDirection = 'DESC',
    int withExtendedInfo = 1,
  ]) async {
    if (page <= pageCount.value) {
      final response = await apiClient.accountTransfers(
          accountHash, page, limit, orderDirection, withExtendedInfo);
      List<dynamic> data = response.data;

      pageCount(response.pageCount ?? 1);
      itemCount(response.itemCount ?? 0);

      final _transfers =
          data.map((val) => TransferModel.fromJson(val)).toList();
      if (transfers.isEmpty) {
        transfers(_transfers);
      } else {
        if (currentPage.value < page) {
          // Load more
          transfers.addAll(_transfers);
          currentPage(page);
        }
      }
    }
  }

  Future<void> getSeedPhrase() async {
    bool seedPhraseAdded = await DBHelper.isSeedPhraseAdded();
    if (seedPhraseAdded) {
      String decryptedSeedPhrase = await GosutoAes256Gcm.decrypt(
          setting?.value.seedPhrase ?? '', setting?.value.password ?? '');
      List<String> _seedPhrases = decryptedSeedPhrase.split(' ');
      seedPhrases(_seedPhrases);
    } else {
      seedPhrases([]);
    }
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

    await DBHelper.updateSettings(
      setting!.value,
      'password',
    );

    newPass('');
    currentPass('');
    rePass('');
  }

  Future<void> getDeployInfo(String deployHash) async {
    final deploy = await apiClient.deployInfo(deployHash);

    var response = await apiClient.deployTransfers(deployHash);
    List<dynamic> data = response.data;

    var amount = data[0]['amount'] ?? '0.0';
    deploy.amount = amount;

    var currencyAmount = data[0]['currency_amount'] ?? '0.0';
    deploy.currencyCost = currencyAmount;

    if (selectedDeloy == null) {
      selectedDeloy = deploy.obs;
    } else {
      selectedDeloy!(deploy);
    }
  }
}
