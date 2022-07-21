import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/database/cache_helper.dart';
import 'package:gosuto/routes/app_pages.dart';
import 'package:gosuto/screens/home/home.dart';

class ChooseWalletTab extends GetView<HomeController> {
  ChooseWalletTab({Key? key}) : super(key: key);

  final ChooseWalletController _cwController =
      Get.put(ChooseWalletController());

  @override
  Widget build(BuildContext context) {
    fetchData();
    return _listViewBuilder();
  }

  Future<void> fetchData() async {
    // delete cache
    await CacheHelper().deleteBalanceCache();
    await _cwController.fetchData();
    controller.selectedWallet ??= _cwController.wallets[0].obs;
  }

  void _onTapWalletItem(int index) {
    final idx = MainTabs.walletHome.index;
    controller.tabController.animateTo(idx);
    controller.selectedWallet?.value = _cwController.wallets[index];
    controller.switchTab(idx);
  }

  Widget _listViewBuilder() {
    return Obx(
      () => ListView.builder(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 22),
        itemCount: _cwController.wallets.length + 1,
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
                      onPressed: () {
                        Get.toNamed(Routes.addWallet);
                      },
                      label: Text(
                        'add_wallet'.tr,
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
                ],
              ),
            );
          }

          return FutureBuilder(
              future: controller.getRate(1),
              builder: ((context, snapshot) {
                var casperPrice = 0.0;
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  casperPrice = double.parse(snapshot.data.toString());
                }
                return GestureDetector(
                    child: WalletCard(
                      wallet: _cwController.wallets[index - 1],
                      rate: casperPrice,
                    ),
                    onTap: () => {_onTapWalletItem(index - 1)});
              }));
        },
      ),
    );
  }
}
