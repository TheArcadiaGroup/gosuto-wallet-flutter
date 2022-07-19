import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/models/models.dart';
import 'package:gosuto/screens/home/home.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toast/toast.dart';

import '../../../../routes/routes.dart';

class WalletHomeTab extends GetView<HomeController> {
  WalletHomeTab({Key? key}) : super(key: key);

  final WalletHomeController _whController = Get.put(WalletHomeController());
  final RxString _selectedFilter = RxString(AppConstants.historyFilterItems[0]);
  final RxInt _currentSliderIdx = RxInt(0);

  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    SizeConfig().init(context);

    _whController.setting = controller.setting;
    _whController.getSeedPhrase();
    _whController.getTransfers(
        controller.selectedWallet?.value.accountHash ?? '',
        _whController.page.value,
        _whController.limit.value,
        'DESC',
        1);

    return Obx(
      () => _buildContent(context),
    );
    // return Obx(
    //   () => Stack(
    //     alignment: AlignmentDirectional.bottomEnd,
    //     children: [
    //       _listViewBuilder(context),
    //       if (_whController.currentTab.value != WalletHomeTabs.walletSettings)
    //         _buildBottomView(context),
    //     ],
    //   ),
    // );
  }

  Widget _buildContent(BuildContext context) {
    final _wallet = controller.selectedWallet?.value;
    return SlidingUpPanel(
      minHeight: AppConstants.heightBottomView,
      maxHeight: AppConstants.maxHeightSlidingUpPanel,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
      controller: _pc,
      color: Theme.of(context).colorScheme.secondaryContainer,
      collapsed: Center(
        child: Text('bottom_text_note'.tr,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2),
      ),
      header: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Center(
          child: GestureDetector(
            onTap: () => {_showHideBottomView(false)},
            child: Container(
              width: 155,
              height: 8,
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              decoration: BoxDecoration(
                  color: const Color(0xFFC4C4C4).withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
            ),
          ),
        ),
      ),
      isDraggable: _whController.selectedTransfer != null,
      onPanelClosed: () => {_showHideBottomView(false)},
      onPanelOpened: () => {_showHideBottomView(true)},
      panel: Padding(
        padding:
            const EdgeInsets.only(top: 70, left: 52, right: 52, bottom: 60),
        child: _whController.isShowBottom.value
            ? TransactionInfoCard(
                rate: controller.rate.value,
                transfer: _whController.selectedTransfer!.value,
                wallet: _wallet!,
              )
            : Container(),
      ),
      body: _listViewBuilder(context),
    );
  }

  int _getItemCountListView(WalletHomeTabs tab) {
    switch (tab) {
      case WalletHomeTabs.history:
        return _whController.transfers.length + 5;
      case WalletHomeTabs.send:
        return 5;
      case WalletHomeTabs.stake:
        return 9;
      case WalletHomeTabs.walletSettings:
        return 4;
      case WalletHomeTabs.swap:
        return 5;
    }
  }

  void _updateBottom(int index) {
    _whController.switchTab(index);
    if (_whController.currentTab.value != WalletHomeTabs.walletSettings) {
      _pc.show();
    } else {
      _pc.hide();
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
            top: 10,
            left: 0,
            right: 0,
            bottom:
                _whController.currentTab.value != WalletHomeTabs.walletSettings
                    ? 2 * AppConstants.heightBottomView
                    : AppConstants.heightBottomView + 20),
        itemCount: _getItemCountListView(_whController.currentTab.value),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                if (controller.selectedWallet != null)
                  WalletCard(
                      wallet: controller.selectedWallet!.value,
                      rate: controller.rate.value),
                FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(Routes.addWallet);
                  },
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
                  controller: _whController.tabController,
                  onTap: (index) => _updateBottom(index),
                  tabs: [
                    CustomTab(
                      text: 'history'.tr,
                      assetName: 'assets/svgs/ic-history.svg',
                      isActive: _whController.currentTab.value ==
                          WalletHomeTabs.history,
                    ),
                    CustomTab(
                      text: 'send'.tr,
                      assetName: 'assets/svgs/ic-send.svg',
                      isActive:
                          _whController.currentTab.value == WalletHomeTabs.send,
                    ),
                    CustomTab(
                      text: 'stake'.tr,
                      assetName: 'assets/svgs/ic-stake.svg',
                      isActive: _whController.currentTab.value ==
                          WalletHomeTabs.stake,
                    ),
                    CustomTab(
                      text: 'wallet_settings'.tr,
                      assetName: 'assets/svgs/ic-wallet-settings.svg',
                      isActive: _whController.currentTab.value ==
                          WalletHomeTabs.walletSettings,
                    ),
                    CustomTab(
                      text: 'swap'.tr,
                      assetName: 'assets/svgs/ic-swap.svg',
                      isActive:
                          _whController.currentTab.value == WalletHomeTabs.swap,
                    ),
                  ]),
            );
          }

          if (index == 2) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Obx(
                        () => Text(
                          controller.selectedWallet?.value.walletName ?? '',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                    SizedBox(
                      // width: 180,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () => {
                          AppClipboard.copyToClipboard(
                              controller.selectedWallet!.value.publicKey)
                        },
                        child: Row(
                          children: [
                            Text(
                              Strings.displayHash(
                                  controller.selectedWallet?.value.publicKey ??
                                      ''),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset('assets/svgs/ic-copy.svg'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (_whController.currentTab.value ==
                    WalletHomeTabs.walletSettings)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'export_wallet_file'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(color: Colors.white, fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }

          if (index ==
                  _getItemCountListView(_whController.currentTab.value) - 1 &&
              _whController.currentTab.value == WalletHomeTabs.history) {
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
                  onPressed: () {
                    _whController.page.value++;
                    _whController.getTransfers(
                        '35305979df049640142981a6f3765519dfd032066a5cb932c674bb56f2044b5b',
                        _whController.page.value,
                        _whController.limit.value,
                        'DESC',
                        1);
                  },
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
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontWeight: FontWeight.normal),
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

    final _wallet = controller.selectedWallet?.value;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 16, right: 16),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(19),
              ),
              child: HistoryItem(
                transfer: _whController.transfers[index - 1],
                wallet: _wallet!,
                rate: controller.rate.value,
              ),
            ),
            onTap: () => {
              _onTapHistoryItem(_whController.transfers[index - 1], _wallet)
            },
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
    return SliderItem(width: widthItem, height: heightItem);
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
                        ?.copyWith(color: Colors.white, fontSize: 12)),
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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
      child: StakeCard(index: index),
    );
  }

  void _changeWalletName(String text) {
    _whController.walletName(text);
  }

  void _changeOldPass(String text) {
    _whController.currentPass(text);
  }

  void _changePass(String text) {
    _whController.newPass(text);
  }

  void _changeRePass(String text) {
    _whController.rePass(text);
  }

  void _showAlert(BuildContext context, String text, {String? btnText}) {
    GosutoDialog().buildDialog(context, [
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ThemeService().isDarkMode
              ? Colors.white
              : const Color(0xFF121826),
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(30),
      ),
      GosutoButton(
        text: btnText ?? 'confirm'.tr,
        style: GosutoButtonStyle.fill,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      )
    ]);
  }

  void _enterPass(String text) {
    _whController.pass(text);
  }

  void _showDialogEnterPass(BuildContext context) {
    GosutoDialog().buildDialog(context, [
      Text(
        'enter_pass_to_copy_private_key'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ThemeService().isDarkMode
              ? Colors.white
              : const Color(0xFF121826),
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(30),
      ),
      CustomWidgets.textField(context, 'password'.tr,
          // controller: _walletName,
          onChanged: _enterPass,
          borderRadius: 12),
      SizedBox(
        height: getProportionateScreenHeight(30),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 51,
            width: getProportionateScreenWidth(160),
            child: ElevatedButton(
              onPressed: () async {
                bool validPass =
                    await _whController.checkPass(_whController.pass.value);
                if (!validPass) {
                  _showAlert(context, 'err_current_pass'.tr);
                  return;
                }
                _whController.pass('');
                Navigator.of(context, rootNavigator: true).pop();
                AppClipboard.copyToClipboard(
                    controller.selectedWallet?.value.privateKey ?? '',
                    func: () => _showAlert(context, 'wallet_key_copied'.tr));
              },
              child: Text(
                'confirm'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 51,
            width: getProportionateScreenWidth(160),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text('cancel'.tr,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).colorScheme.background)),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary,
                side: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).colorScheme.background),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Future<void> _changePassword(BuildContext context) async {
    bool validPass =
        await _whController.checkPass(_whController.currentPass.value);
    if (!validPass) {
      _showAlert(context, 'err_current_pass'.tr);
      return;
    }

    if (_whController.newPass.value.trim() == '') {
      _showAlert(context, 'err_empty_pass'.tr);
      return;
    }

    if (_whController.newPass.value != _whController.rePass.value) {
      _showAlert(context, 'err_pass_re_pass'.tr);
      return;
    }

    await _whController.updatePassword();
    _showAlert(context, 'update_pass_success'.tr);
  }

  void _updateWalletName(BuildContext context) async {
    if (controller.selectedWallet != null) {
      controller.selectedWallet!.value.walletName =
          _whController.walletName.value;
      controller.selectedWallet?.refresh();
      await _whController.updateWallet(controller.selectedWallet!.value);
      _showAlert(context, 'update_wallet_success'.tr);
    }
  }

  Widget _buildMnemonicItem(BuildContext context, String num, String label) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.circular(37),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, -1), // changes position of shadow
            ),
          ]),
      child: RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                width: 21,
                height: 21,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  num,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 12),
                ),
              ),
            ),
            TextSpan(
                text: "  " + label,
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletSettings(BuildContext context, int index) {
    TextEditingController _walletName = TextEditingController(
        text: controller.selectedWallet?.value.walletName);
    TextEditingController _oldPass =
        TextEditingController(text: _whController.currentPass.value);
    TextEditingController _pass =
        TextEditingController(text: _whController.newPass.value);
    TextEditingController _rePass =
        TextEditingController(text: _whController.rePass.value);
    TextEditingController _publicKeyController =
        TextEditingController(text: controller.selectedWallet?.value.publicKey);
    TextEditingController _privateKeyController = TextEditingController(
        text: controller.selectedWallet?.value.privateKey.toString());
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.textField(context, 'wallet_name'.tr,
              controller: _walletName,
              onChanged: _changeWalletName,
              borderRadius: 12),
          const SizedBox(height: 20),
          // Stack(
          //   alignment: AlignmentDirectional.topStart,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(top: 10, bottom: 10),
          //       child: Container(
          //         padding: const EdgeInsets.only(
          //             top: 20, bottom: 20, left: 13, right: 13),
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(12),
          //           border: Border.all(
          //             color: Theme.of(context).colorScheme.onSecondary,
          //             width: 1.0,
          //           ),
          //         ),
          //         child: Obx(
          //           () => Wrap(
          //             spacing: 11,
          //             runSpacing: 15,
          //             children: [
          //               for (int i = 0;
          //                   i < _whController.seedPhrases.length;
          //                   i++)
          //                 _buildMnemonicItem(context, '${i + 1}',
          //                     _whController.seedPhrases[i]),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 20, top: 3),
          //       child: Container(
          //         color: Theme.of(context).colorScheme.primary,
          //         child: Text(
          //           'Mnemonic',
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyText1
          //               ?.copyWith(fontSize: 12),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 20),
          CustomWidgets.textField(
            context,
            'public_key'.tr,
            // onChanged: _changePublicKey,
            borderRadius: 12,
            controller: _publicKeyController,
            enable: false,
          ),
          const SizedBox(height: 20),
          CustomWidgets.textField(
            context, 'private_key'.tr,
            borderRadius: 12,
            controller: _privateKeyController,
            // enable: false,
            enableInteractiveSelection: false,
            readOnly: true,
            obscureText: true,

            suffixIcon: IconButton(
              onPressed: () => {_showDialogEnterPass(context)},
              icon: SvgPicture.asset(
                'assets/svgs/ic-copy.svg',
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 10, top: 15, bottom: 15),
            //   child: SvgPicture.asset(
            //     'assets/svgs/ic-copy.svg',
            //     color: Theme.of(context).colorScheme.background,
            //   ),
            // ),
          ),
          const SizedBox(height: 20),
          Text(
            'change_password'.tr,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 20),
          CustomWidgets.textField(
            context,
            'current_password'.tr,
            onChanged: _changeOldPass,
            controller: _oldPass,
            borderRadius: 12,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          CustomWidgets.textField(
            context,
            'new_password'.tr,
            onChanged: _changePass,
            controller: _pass,
            borderRadius: 12,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          CustomWidgets.textField(
            context,
            're_enter_new_password'.tr,
            onChanged: _changeRePass,
            controller: _rePass,
            borderRadius: 12,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _oldPass.clear();
              _pass.clear();
              _rePass.clear();
              _changePassword(context);
            },
            child: Text('change_password'.tr,
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 51,
                width: 150,
                child: ElevatedButton(
                  onPressed: () => _updateWalletName(context),
                  child: Text(
                    'save'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 51,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('cancel'.tr,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).colorScheme.background)),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                    side: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.background),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // Widget _buildSwap(BuildContext context, int index) {
  //   return Container();
  // }

  // Widget _buildBottomView(BuildContext context) {
  //   // TODO Fake publickey
  //   final _wallet = controller.selectedWallet?.value;
  //   _wallet?.publicKey =
  //       '017a3a850401c1933057fc40e1948c355405fa8d72943a5c1b2ce33605dab3cbf5';
  //   return Obx(() => AnimatedContainer(
  //         decoration: BoxDecoration(
  //           borderRadius:
  //               const BorderRadius.vertical(top: Radius.circular(30.0)),
  //           color: Theme.of(context).colorScheme.secondaryContainer,
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withAlpha(12),
  //               spreadRadius: 5,
  //               blurRadius: 7,
  //               offset: const Offset(0, -1), // changes position of shadow
  //             ),
  //           ],
  //         ),
  //         height: _whController.isShowBottom.value ? 550 : AppConstants.heightBottomView,
  //         width: MediaQuery.of(context).size.width,
  //         duration: const Duration(milliseconds: 500),
  //         child: Stack(
  //           alignment: Alignment.topCenter,
  //           children: [
  //             SingleChildScrollView(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 70, left: 52, right: 52, bottom: 60),
  //                 child: _whController.isShowBottom.value
  //                     ? TransactionInfoCard(
  //                         rate: controller.rate.value,
  //                         transfer: _whController.selectedTransfer!.value,
  //                         wallet: _wallet!,
  //                       )
  //                     : Text('bottom_text_note'.tr,
  //                         maxLines: 2,
  //                         textAlign: TextAlign.center,
  //                         style: Theme.of(context).textTheme.subtitle2),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () => {_showHideBottomView(false)},
  //               child: Container(
  //                 width: 155,
  //                 height: 8,
  //                 margin: const EdgeInsets.only(top: 12),
  //                 decoration: BoxDecoration(
  //                     color: const Color(0xFFC4C4C4).withOpacity(0.3),
  //                     borderRadius:
  //                         const BorderRadius.all(Radius.circular(30))),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ));
  // }

  void _showHideBottomView(bool isShow) {
    _whController.isShowBottom(isShow);
    if (isShow) {
      _pc.open();
    } else {
      _pc.close();
      _whController.selectedTransfer = null;
    }
  }

  void _changeFilter(value) {
    _selectedFilter(value);
  }

  void _onTapHistoryItem(TransferModel transfer, WalletModel wallet) {
    _showHideBottomView(true);
    // _whController.selectedTransfer = transfer.obs;
    // _whController.selectedTransfer?.refresh();
    if (_whController.selectedTransfer == null) {
      _whController.selectedTransfer = transfer.obs;
    } else {
      _whController.selectedTransfer!(transfer);
    }
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
