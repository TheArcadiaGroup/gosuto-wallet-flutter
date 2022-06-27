import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/screens/home/home.dart';

class CurrencyPerformanceTab extends GetView<HomeController> {
  CurrencyPerformanceTab({Key? key}) : super(key: key);

  final CurrencyPerformanceController _cpController =
      Get.put(CurrencyPerformanceController());

  @override
  Widget build(BuildContext context) {
    _cpController.getMarketCharts(
        _cpController.vsCurrency.value, _cpController.days.value);

    return _listViewBuilder(context);
    // return Obx(
    //   () => _listViewBuilder(context),
    // );
  }

  void _updateFilter(int value) {
    _cpController.days(value);
    _cpController.getMarketCharts(_cpController.vsCurrency.value, value);
  }

  Widget _listViewBuilder(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 22),
      itemCount: 5,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            if (controller.selectedWallet != null)
              WalletCard(wallet: controller.selectedWallet!.value),
            FloatingActionButton(
              onPressed: () => {},
              child: Image.asset('assets/images/ic-add.png'),
            )
          ]);
        }
        if (index == 1) {
          return Padding(
              padding: const EdgeInsets.all(10),
              child: Text('currencies_own'.tr,
                  style: Theme.of(context).textTheme.headline1));
        }
        return Obx(() => ChartCard(
            data: _cpController.prices.value, onUpdateFilter: _updateFilter));
      },
    );
  }
}
