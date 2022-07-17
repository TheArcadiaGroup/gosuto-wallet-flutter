import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/screens/home/home.dart';
// import 'package:gosuto/services/coin_service.dart';

class CurrencyPerformanceTab extends GetView<HomeController> {
  CurrencyPerformanceTab({Key? key}) : super(key: key);

  final CurrencyPerformanceController _cpController =
      Get.put(CurrencyPerformanceController());

  @override
  Widget build(BuildContext context) {
    _cpController.getMarketCharts(_cpController.days.value);
    _cpController.getCasperNetwork();

    return _listViewBuilder(context);
    // return Obx(
    //   () => _listViewBuilder(context),
    // );
  }

  void _updateFilter(int value) {
    _cpController.days(value);
    _cpController.getMarketCharts(value);
  }

  Widget _listViewBuilder(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 22),
      itemCount: 3,
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

        // final currentPriceModel =
        //     _cpController.casperNetwork?.value.marketData.currentPrice;

        // final currentPrice = CoinService().coin == 'USD'
        //     ? currentPriceModel?.usd
        //     : currentPriceModel?.eur;

        return Obx(() => ChartCard(
              data: _cpController.prices[0].value,
              onUpdateFilter: _updateFilter,
              // currentPrice: currentPrice ?? 0,
              // percentChanged: _cpController.casperNetwork?.value.marketData
              //         .priceChangePercentage24h ??
              //     0,
              casperNetwork: _cpController.casperNetwork?.value,
            ));
      },
    );
  }
}
