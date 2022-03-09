import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/screens/home/home.dart';
import 'package:gosuto/utils/utils.dart';

class WalletHomeTab extends GetView<WalletHomeController> {
  WalletHomeTab({Key? key}) : super(key: key);

  final WalletHomeController _whController = Get.put(WalletHomeController());
  final RxString _selectedFilter = RxString(AppConstants.historyFilterItems[0]);
  final double _heightBottomView = 167;
  final RxInt _currentSliderIdx = RxInt(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [_listViewBuilder(context), _buildBottomView(context)]);
  }

  int _getItemCountListView(WalletHomeTabs tab) {
    switch (tab) {
      case WalletHomeTabs.history:
        return 9;
      case WalletHomeTabs.send:
        return 5;
      case WalletHomeTabs.stake:
        return 3;
      case WalletHomeTabs.walletSettings:
        return 3;
      case WalletHomeTabs.swap:
        return 5;
    }
  }

  Widget _buildViewItemList(
      WalletHomeTabs tab, BuildContext context, int index) {
    switch (tab) {
      case WalletHomeTabs.history:
        return _buildHistory(context, index);
      case WalletHomeTabs.send:
        return _buildSend(context, index);
      case WalletHomeTabs.stake:
        return _buildStake(context, index);
      case WalletHomeTabs.walletSettings:
        return _buildWalletSettings(context, index);
      case WalletHomeTabs.swap:
        return _buildSend(context, index);
    }
  }

  Widget _listViewBuilder(BuildContext context) {
    double horizontalPadding = (MediaQuery.of(context).size.width - 97) / 2;

    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.only(
            top: 10, left: 0, right: 0, bottom: _heightBottomView),
        itemCount: _getItemCountListView(_whController.currentTab.value),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                const WalletCard(),
                FloatingActionButton(
                  onPressed: () => {},
                  child: Image.asset('assets/images/ic-add.png'),
                )
              ]),
            );
          }

          if (index == 1) {
            double wTab = 80;
            double hTab = 70;
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  controller: _whController.tabController,
                  onTap: (index) => _whController.switchTab(index),
                  tabs: [
                    SizedBox(
                      width: wTab,
                      height: hTab,
                      child: Tab(
                        text: 'history'.tr,
                        icon:
                            SvgPicture.asset('assets/svgs/dark/ic-history.svg'),
                      ),
                    ),
                    SizedBox(
                      width: wTab,
                      height: hTab,
                      child: Tab(
                        text: 'send'.tr,
                        icon: SvgPicture.asset('assets/svgs/dark/ic-send.svg'),
                      ),
                    ),
                    SizedBox(
                      width: wTab,
                      height: hTab,
                      child: Tab(
                        text: 'stake'.tr,
                        icon: SvgPicture.asset('assets/svgs/ic-stake.svg'),
                      ),
                    ),
                    SizedBox(
                      width: wTab,
                      height: hTab,
                      child: Tab(
                        child: Text(
                          'wallet_settings'.tr,
                          textAlign: TextAlign.center,
                        ),
                        icon: SvgPicture.asset(
                            'assets/svgs/ic-wallet-settings.svg'),
                      ),
                    ),
                    SizedBox(
                      width: wTab,
                      height: hTab,
                      child: Tab(
                        text: 'swap'.tr,
                        icon: SvgPicture.asset('assets/svgs/ic-swap.svg'),
                      ),
                    ),
                  ]),
            );
          }

          if (index == 2) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Wallet1',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Text(
                          '0x9f98e01d2...4ed7 ',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SvgPicture.asset('assets/svgs/ic-copy.svg'),
                      ],
                    ),
                  ),
                )
              ],
            );
          }

          if (index == 8) {
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
                  child: Text('show_more'.tr,
                      style: Theme.of(context).textTheme.headline4),
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
              _whController.currentTab.value, context, index - 3);
        },
      ),
    );
  }

  Widget _buildHistory(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('stake_from_this_wallet'.tr,
                style: Theme.of(context).textTheme.headline1),
            SizedBox(
              height: 36,
              width: 142,
              child: DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton2(
                    value: _selectedFilter.value,
                    style: Theme.of(context).textTheme.subtitle1,
                    items: _buildDropDownMenuItems(),
                    onChanged: _changeFilter,
                    buttonHeight: 35,
                    buttonPadding: const EdgeInsets.only(left: 12),
                    alignment: Alignment.centerLeft,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    dropdownDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    dropdownWidth: 142,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 16, right: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(19),
            ),
            child: HistoryItem(index: index),
          ),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSlider(
      BuildContext context, double widthItem, double heightItem) {
    double wItem = widthItem - 29;
    double hItem = heightItem - 10;
    return SliderItem(width: wItem, height: hItem);
  }

  Widget _buildSend(BuildContext context, int idx) {
    if (idx == 0) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('tokens_in_this_wallet'.tr,
                style: Theme.of(context).textTheme.headline1),
            SizedBox(
              height: 36,
              child: ElevatedButton.icon(
                icon: Image.asset('assets/images/ic-add-no-bg.png'),
                onPressed: () {},
                label: Text('add_token'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    double widthItem = MediaQuery.of(context).size.width / 2;
    double heightItem = 125;

    final _sliderList = [
      _buildItemsSlider(context, widthItem, heightItem),
      _buildItemsSlider(context, widthItem, heightItem),
      _buildItemsSlider(context, widthItem, heightItem)
    ];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 250,
              aspectRatio: 1.0,
              enableInfiniteScroll: false,
              // enlargeCenterPage: true,
              // scrollDirection: Axis.vertical,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                _currentSliderIdx(index);
              }),
          items: _sliderList,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _sliderList.asMap().entries.map((entry) {
              return _currentSliderIdx.value == entry.key
                  ? Container(
                      width: 8,
                      height: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    )
                  : Container(
                      width: 4.0,
                      height: 4.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        shape: BoxShape.rectangle,
                        color: const Color(0xFFC4C4C4).withOpacity(0.35),
                      ),
                    );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildStake(BuildContext context, int index) {
    return Container();
  }

  Widget _buildWalletSettings(BuildContext context, int index) {
    return Container();
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
          height: _whController.isShowBottom.value ? 550 : _heightBottomView,
          width: MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 500),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 70, left: 52, right: 52, bottom: 60),
                  child: _whController.isShowBottom.value
                      ? const TransactionInfoCard()
                      : Text(
                          'bottom_text_note'.tr,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    {_showHideBottomView(!_whController.isShowBottom.value)},
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
    _whController.isShowBottom(isShow);
  }

  void _changeFilter(value) {
    _selectedFilter(value);
  }

  List<DropdownMenuItem<String>> _buildDropDownMenuItems() {
    return AppConstants.historyFilterItems.map((String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    }).toList();
  }
}
