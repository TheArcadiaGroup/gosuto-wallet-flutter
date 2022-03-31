import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/screens/home/home.dart';

class StakeTab extends GetView<HomeController> {
  StakeTab({Key? key}) : super(key: key);

  final StakeController _sController = Get.put(StakeController());
  final double _heightBottomView = 167;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        _listViewBuilder(context),
        if (_sController.currentTab.value == StakeTabs.all)
          _buildBottomView(context),
      ]),
    );
  }

  int _getItemCountListView(StakeTabs tab) {
    switch (tab) {
      case StakeTabs.all:
        return 7 + 3;
      case StakeTabs.validators:
        return 4 + 3;
    }
  }

  Widget _buildViewItemList(StakeTabs tab, BuildContext context, int index) {
    switch (tab) {
      case StakeTabs.all:
        return _buildAllPositions(context, index);
      case StakeTabs.validators:
        return _buildValidators(context, index);
    }
  }

  Widget _listViewBuilder(BuildContext context) {
    double horizontalPadding = (MediaQuery.of(context).size.width - 97) / 2;

    return Obx(
          () => ListView.builder(
        padding: EdgeInsets.only(
            top: 10,
            left: 0,
            right: 0,
            bottom: _sController.currentTab.value == StakeTabs.all
                ? _heightBottomView
                : 10),
        itemCount: _getItemCountListView(_sController.currentTab.value),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child:
              Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                if (controller.selectedWallet != null)
                  WalletCard(wallet: controller.selectedWallet!.value),
                FloatingActionButton(
                  onPressed: () => {},
                  child: Image.asset('assets/images/ic-add.png'),
                )
              ]),
            );
          }

          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  controller: _sController.tabController,
                  onTap: (index) => _sController.switchTab(index),
                  tabs: [
                    CustomTab(
                      text: 'all_positions'.tr,
                      assetName: 'assets/svgs/ic-all-positions.svg',
                      isActive: _sController.currentTab.value == StakeTabs.all,
                    ),
                    CustomTab(
                      text: 'validators'.tr,
                      assetName: 'assets/svgs/ic-validators.svg',
                      isActive:
                      _sController.currentTab.value == StakeTabs.validators,
                    ),
                  ]),
            );
          }

          if (index == 2) {
            return _sController.currentTab.value == StakeTabs.validators
                ? Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'validators'.tr,
                style: Theme.of(context).textTheme.headline1,
              ),
            )
                : const SizedBox(height: 20);
          }

          if (index ==
              _getItemCountListView(_sController.currentTab.value) - 1) {
            return Padding(
              padding: EdgeInsets.only(
                top: 37,
                bottom: 34,
                left: horizontalPadding,
                right: horizontalPadding,
              ),
              child: SizedBox(
                height: 40,
                width: 97,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'show_more'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                    side: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).colorScheme.onPrimary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            );
          }

          return _buildViewItemList(
              _sController.currentTab.value, context, index - 3);
        },
      ),
    );
  }

  Widget _buildValidators(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 16, right: 16),
      child: Column(
        children: [
          const ValidatorItem(),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildAllPositions(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
      child: StakeCard(index: index),
    );
  }

  Widget _buildBottomView(BuildContext context) {
    return Obx(() => AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius:
        const BorderRadius.vertical(top: Radius.circular(30.0)),
        color: Theme.of(context).colorScheme.secondaryContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // changes position of shadow
          ),
        ],
      ),
      height: _sController.isShowBottom.value ? 550 : _heightBottomView,
      width: MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 500),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 70, left: 52, right: 52, bottom: 60),
              child: _sController.isShowBottom.value
                  ? const TransactionInfoCard()
                  : Text(
                'select_a_position_to_take_actions'.tr,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
            {_showHideBottomView(!_sController.isShowBottom.value)},
            child: Container(
              width: 155,
              height: 8,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                  color: const Color(0xFFC4C4C4).withOpacity(0.3),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(30))),
            ),
          ),
        ],
      ),
    ));
  }

  void _showHideBottomView(bool isShow) {
    _sController.isShowBottom(isShow);
  }
}
