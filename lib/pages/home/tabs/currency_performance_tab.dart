import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/pages/home/home.dart';

class CurrencyPerformanceTab extends GetView<HomeController> {
  const CurrencyPerformanceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _listViewBuilder();
  }

  Widget _listViewBuilder() {
    return ListView.builder(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 22),
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
              const WalletCard(),
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
          return const ChartCard();
        });
  }
}
