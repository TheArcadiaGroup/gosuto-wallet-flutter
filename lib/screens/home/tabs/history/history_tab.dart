import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/screens/home/home.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:gosuto/routes/routes.dart';

import 'history.dart';

class HistoryTab extends GetView<HomeController> {
  HistoryTab({Key? key}) : super(key: key);

  final HistoryController _hController = Get.put(HistoryController());
  final RxString _selectedFilter = RxString(AppConstants.historyFilterItems[0]);
  final double _heightBottomView = 167;

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [_listViewBuilder(context), _buildBottomView(context)]);
  }

  Widget _listViewBuilder(BuildContext context) {
    double horizontalPadding = (MediaQuery.of(context).size.width - 97) / 2;
    return Obx(
          () => ListView.builder(
        padding: EdgeInsets.only(
            top: 10, left: 0, right: 0, bottom: _heightBottomView),
        itemCount: _hController.transfers.length + 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  if (controller.selectedWallet != null)
                    WalletCard(wallet: controller.selectedWallet!.value),
                  FloatingActionButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.addWallet);
                    },
                    child: Image.asset('assets/images/ic-add.png'),
                  )
                ],
              ),
            );
          }
          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('all_history'.tr,
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

          if (index == _hController.transfers.length + 2) {
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
                    _hController.page.value++;
                    _hController.getTransfers(
                        '35305979df049640142981a6f3765519dfd032066a5cb932c674bb56f2044b5b',
                        _hController.page.value,
                        _hController.limit.value,
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

          // TODO Fake publickey
          final _wallet = controller.selectedWallet?.value;
          _wallet?.publicKey =
          '017a3a850401c1933057fc40e1948c355405fa8d72943a5c1b2ce33605dab3cbf5';
          print(controller.rate.obs);

          return Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: HistoryItem(
                    transfer: _hController.transfers[index - 2],
                    wallet: _wallet!,
                    rate: controller.rate.value,
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  height: 1,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showHideBottomView(bool isShow) {
    _hController.isShowBottom(isShow);
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
      height: _hController.isShowBottom.value ? 550 : _heightBottomView,
      width: MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 500),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 70, left: 52, right: 52, bottom: 60),
              child: _hController.isShowBottom.value
                  ? const TransactionInfoCard(subTitle: 'Wallet1')
                  : Text(
                'bottom_text_note'.tr,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
            {_showHideBottomView(!_hController.isShowBottom.value)},
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
}
