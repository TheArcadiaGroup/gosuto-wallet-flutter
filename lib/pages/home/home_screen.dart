import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    tabs: [
                      Tab(icon: Image.asset('assets/images/dark/ic-tab1.png')),
                      Tab(icon: Image.asset('assets/images/dark/ic-tab2.png')),
                      Tab(icon: Image.asset('assets/images/dark/ic-tab3.png')),
                      Tab(icon: Image.asset('assets/images/dark/ic-tab4.png')),
                      Tab(icon: Image.asset('assets/images/dark/ic-tab5.png')),
                      Tab(icon: Image.asset('assets/images/dark/ic-tab6.png')),
                      Tab(icon: Image.asset('assets/images/dark/ic-tab7.png')),
                    ],
                    onTap: (index) => controller.switchTab(index),
                  )
                ],
              ),
            ),
            body: _buildContent(controller.currentTab.value)));
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.chooseWallet:
        return controller.chooseWalletTab;
      case MainTabs.walletHome:
        return controller.walletHomeTab;
      case MainTabs.tab3:
        return const Tab(icon: Icon(Icons.flight, size: 350));
      case MainTabs.history:
        return controller.historyTab;
      case MainTabs.tab5:
        return const Tab(icon: Icon(Icons.flight, size: 350));
      case MainTabs.currencyPerformance:
        return controller.currencyPerformanceTab;
      case MainTabs.accountSetting:
        return controller.accountSettingTab;
      default:
        return const Tab(icon: Icon(Icons.flight, size: 350));
    }
  }
}
