import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/pages/home/home.dart';

import '../../../themes/colors.dart';

class ChooseWalletTab extends GetView<HomeController> {
  const ChooseWalletTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _listViewBuilder();
  }

  void _onTapWalletItem() {
    final idx = MainTabs.currencyPerformance.index;
    controller.tabController.animateTo(idx);
    controller.switchTab(idx);
  }

  Widget _listViewBuilder() {
    return ListView.builder(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 22),
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('select_wallet'.tr,
                      style: Theme.of(context).textTheme.headline1),
                  SizedBox(
                    height: 36,
                    child: ElevatedButton.icon(
                      icon: Image.asset('assets/images/ic-add-no-bg.png'),
                      onPressed: () {},
                      label: Text('add_wallet'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: AppDarkColors.orangeColor,
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

          return GestureDetector(
              child: const WalletCard(), onTap: _onTapWalletItem);
        });
  }
}
