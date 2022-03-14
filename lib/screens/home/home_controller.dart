import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/utils/utils.dart';

import 'home.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var currentTab = MainTabs.chooseWallet.obs;
  var isDarkMode = ThemeService().isDarkMode.obs;
  var avatarPath = "".obs;
  var selectedLanguage = TranslationService().locale.languageCode.obs;
  var selectedCoin = AppConstants.coins[0].obs;

  late TabController tabController;
  late AccountSettingTab accountSettingTab;
  late CurrencyPerformanceTab currencyPerformanceTab;
  late ChooseWalletTab chooseWalletTab;
  late WalletHomeTab walletHomeTab;
  late HistoryTab historyTab;
  late StakeTab stakeTab;

  @override
  void onInit() {
    super.onInit();
    accountSettingTab = AccountSettingTab();
    currencyPerformanceTab = const CurrencyPerformanceTab();
    chooseWalletTab = const ChooseWalletTab();
    walletHomeTab =  WalletHomeTab();
    historyTab = HistoryTab();
    stakeTab = StakeTab();

    tabController = TabController(length: MainTabs.values.length, vsync: this);
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  void loadUser() {}

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.chooseWallet:
        return 0;
      case MainTabs.walletHome:
        return 1;
      // case MainTabs.tab3:
      //   return 2;
      case MainTabs.history:
        return 2;
      case MainTabs.stake:
        return 3;
      case MainTabs.currencyPerformance:
        return 4;
      case MainTabs.accountSetting:
        return 5;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.chooseWallet;
      case 1:
        return MainTabs.walletHome;
      // case 2:
      //   return MainTabs.tab3;
      case 2:
        return MainTabs.history;
      case 3:
        return MainTabs.stake;
      case 4:
        return MainTabs.currencyPerformance;
      case 5:
        return MainTabs.accountSetting;
      default:
        return MainTabs.chooseWallet;
    }
  }
}
