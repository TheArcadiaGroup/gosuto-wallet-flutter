import 'package:get/get.dart';
import 'package:gosuto/data/network/network.dart';
import 'package:gosuto/models/casper_network_model.dart';
import 'package:gosuto/models/market_chart_model.dart';
import 'package:gosuto/models/wallet.dart';
import 'package:gosuto/services/coin_service.dart';

class CurrencyPerformanceController extends GetxController {
  List<Wallet> wallets = <Wallet>[].obs;
  late ApiClient apiClient;
  var vsCurrency = 'usd'.obs;
  var days = 1.obs;

  RxList prices = RxList<List>();

  Rx<CasperNetworkModel>? casperNetwork;

  @override
  void onInit() {
    super.onInit();

    apiClient =
        ApiClient(Get.find(), baseUrl: 'https://api.coingecko.com/api/v3/');
  }

  Future<void> getMarketCharts(int days) async {
    final vsCurrency = CoinService().coin;
    final response = await apiClient.marketChart(vsCurrency, days);
    final _marketChart = MarketChartModel.fromJson(response.data);
    prices(_marketChart.prices);
  }

  Future<void> getCasperNetwork() async {
    final response = await apiClient.casperNetwork();
    final _data = CasperNetworkModel.fromJson(response.data);
    casperNetwork ??= _data.obs;
  }
}
