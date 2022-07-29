import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/models/wallet_model.dart';
import 'package:gosuto/screens/home/tabs/tabs.dart';
import 'package:gosuto/utils/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HistorySubTab extends GetView<WalletHomeController> {
  HistorySubTab({Key? key, required this.wallet}) : super(key: key);

  final WalletModel wallet;
  final WalletHomeController _whController = Get.put(WalletHomeController());
  final RxString _selectedFilter = RxString(AppConstants.historyFilterItems[0]);
  final RxBool _loading = RxBool(false);

  Future<void> fetchDeploys() async {
    EasyLoading.show();
    await _whController.getAccountDeploys(wallet.publicKey);
    EasyLoading.dismiss();

    _whController.backupDeploys.assignAll(_whController.deploys.toList());
  }

  void _changeFilter(value) {
    _selectedFilter(value);
    var filter = value.toString().toLowerCase();

    switch (filter) {
      case 'sent':
        var filteredDeploys = _whController.backupDeploys
            .where((e) => e.executionTypeId == 6)
            .toList();
        _whController.deploys.assignAll(filteredDeploys);
        break;
      // case 'received':
      //   var filteredTransfers = _whController.backupDeploys
      //       .where((e) =>
      //           e.fromAccountPublicKey.toLowerCase() != publicKey &&
      //           e.toAccountPublicKey != null &&
      //           e.toAccountPublicKey?.toLowerCase() == publicKey)
      //       .toList();
      //   _whController.deploys.assignAll(filteredTransfers);
      //   break;
      case 'swap':
        var filteredTransfers = _whController.backupDeploys.where((e) {
          if (e.executionTypeId == 1) {
            var args = e.args as Map<dynamic, dynamic>;
            if (args.containsKey('deposit_entry_point_name')) {
              return args['deposit_entry_point_name']['parsed']
                  .toString()
                  .contains('swap');
            }
          }
          if (e.executionTypeId == 2 && e.entryPoint != null) {
            return e.entryPoint?.name.contains('swap') ?? false;
          }
          return false;
        }).toList();
        _whController.deploys.assignAll(filteredTransfers);
        break;
      case 'contract interaction':
        var filteredTransfers = _whController.backupDeploys
            .where((e) => e.executionTypeId == 2 || e.executionTypeId == 1)
            .toList();
        _whController.deploys.assignAll(filteredTransfers);
        break;
      case 'all':
      default:
        _whController.deploys.assignAll(_whController.backupDeploys.toList());
        break;
    }
  }

  List<DropdownMenuItem<String>> _buildDropDownMenuItems() {
    return AppConstants.historyFilterItems
        .map((item) => DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontSize: 12),
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    _whController.currentPage.value = 1;
    _whController.deploys.clear();
    _whController.backupDeploys.clear();

    _selectedFilter(AppConstants.historyFilterItems[0]);

    fetchDeploys();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('deploys'.tr, style: Theme.of(context).textTheme.headline1),
              SizedBox(
                height: 36,
                width: 144,
                child: DropdownButtonHideUnderline(
                  child: Obx(
                    () => DropdownButton2(
                      alignment: Alignment.centerLeft,
                      value: _selectedFilter.value,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 15,
                      items: _buildDropDownMenuItems(),
                      itemHeight: 40,
                      buttonHeight: 35,
                      buttonPadding: const EdgeInsets.only(left: 12),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      dropdownOverButton: true,
                      dropdownDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      dropdownWidth: 145,
                      dropdownElevation: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontWeight: FontWeight.normal),
                      onChanged: _changeFilter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => (_whController.deploys.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _whController.deploys.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Obx(
                            () => HistoryItem(
                              deploy: _whController.deploys[index],
                              wallet: wallet,
                              disabled: _loading.value,
                              isSelected:
                                  index == _whController.selectedIndex.value,
                              onTap: () async {
                                try {
                                  _whController.selectedIndex(index);
                                  EasyLoading.show();
                                  _loading(true);

                                  await _whController.getDeployInfo(
                                      _whController.deploys[index].deployHash);

                                  showCupertinoModalBottomSheet(
                                    context: context,
                                    expand: false,
                                    topRadius: const Radius.circular(30),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    builder: (context) {
                                      return TransferInfoCard(
                                        wallet: wallet,
                                        deploy:
                                            _whController.selectedDeloy?.value,
                                      );
                                    },
                                  );
                                } catch (e) {
                                  EasyLoading.showToast(
                                      'fetch_deploy_details_error'.tr);
                                } finally {
                                  _loading(false);
                                  EasyLoading.dismiss();
                                }
                              },
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container()),
        ),
        Obx(
          () => (_whController.currentPage.value <
                      _whController.pageCount.value &&
                  _selectedFilter.value == AppConstants.historyFilterItems[0]
              ? Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 97,
                    child: ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show();
                        await _whController.getAccountDeploys(
                          wallet.publicKey,
                          _whController.currentPage.value + 1,
                        );
                        _whController.backupDeploys
                            .assignAll(_whController.deploys.toList());
                        EasyLoading.dismiss();
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
                        elevation: 0.0,
                        side: BorderSide(
                            width: 2.0,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(100)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(),
                )),
        )
      ],
    );
  }
}
