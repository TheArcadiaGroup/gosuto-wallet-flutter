import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/services/service.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'home.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget(context)),
    );
  }

  Widget _buildWidget(BuildContext context) {
    final selectedIdx = controller.getCurrentIndex(controller.currentTab.value);
    return DefaultTabController(
        length: 6,
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: Tab(
                            icon: ThemeService().isDarkMode
                                ? SvgPicture.asset(
                                    'assets/svgs/dark/ic-menu.svg')
                                : SvgPicture.asset(
                                    'assets/svgs/light/ic-menu.svg')),
                      ),
                      Expanded(
                        child: TabBar(
                          controller: controller.tabController,
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          tabs: [
                            Tab(
                                icon:
                                    Image.asset('assets/images/ic-tab-2.png')),
                            Tab(
                                icon:
                                    Image.asset('assets/images/ic-tab-3.png')),
                            Tab(
                                icon: SvgPicture.asset(
                                    'assets/svgs/ic-history.svg',
                                    color: selectedIdx == 2
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onTertiary)),
                            Tab(
                                icon: SvgPicture.asset(
                                    'assets/svgs/ic-stake.svg',
                                    color: selectedIdx == 3
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onTertiary)),
                            Tab(
                                icon: SvgPicture.asset(
                                    'assets/svgs/ic-performance.svg',
                                    color: selectedIdx == 4
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onTertiary)),
                            Tab(
                                icon: SvgPicture.asset(
                                    'assets/svgs/ic-setting.svg',
                                    color: selectedIdx == 5
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onTertiary)),
                          ],
                          onTap: (index) => controller.switchTab(index),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            body: EasyRefresh(
              controller: _refreshController,
              header: const ClassicHeader(),
              onRefresh: () async {
                await controller.chooseWalletTab.fetchData();
                _refreshController.finishRefresh();
              },
              onLoad: () {
                _refreshController.finishLoad(IndicatorResult.success);
              },
              child: _buildContent(controller.currentTab.value),
            )));
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.chooseWallet:
        return controller.chooseWalletTab;
      case MainTabs.walletHome:
        return controller.walletHomeTab;
      // case MainTabs.tab3:
      //   return const Tab(icon: Icon(Icons.flight, size: 350));
      case MainTabs.history:
        return controller.historyTab;
      case MainTabs.stake:
        return controller.stakeTab;
      case MainTabs.currencyPerformance:
        return controller.currencyPerformanceTab;
      case MainTabs.accountSetting:
        return controller.accountSettingTab;
      default:
        return const Tab(icon: Icon(Icons.flight, size: 350));
    }
  }
}
