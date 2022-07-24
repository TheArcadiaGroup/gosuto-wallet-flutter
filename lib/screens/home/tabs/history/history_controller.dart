import 'package:get/get.dart';

import '../../../../data/network/network.dart';
import '../../../../env/env.dart';
import '../../../../models/models.dart';

class HistoryController extends GetxController {
  var isShowBottom = false.obs;

  RxList<TransferModel> transfers = RxList<TransferModel>();
  late ApiClient apiClient;

  var currentPage = 1.obs;
  var limit = 10.obs;

  Rx<TransferModel>? selectedTransfer;
  // Rx<Wallet>? wallet;

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');

    // TODO: Fake
    // accountHash = '35305979df049640142981a6f3765519dfd032066a5cb932c674bb56f2044b5b'
    // page=1&limit=10&order_direction=DESC&with_extended_info=1
    // getTransfers(
    //     '35305979df049640142981a6f3765519dfd032066a5cb932c674bb56f2044b5b',
    //     page.value,
    //     limit.value,
    //     'DESC',
    //     1);
  }

  @override
  void onClose() {
    transfers.clear();
    super.dispose();
  }

  Future<void> getTransfers(String accountHash, int page, int limit,
      String orderDirection, int withExtendedInfo) async {
    final response = await apiClient.accountsTransfers(
        accountHash, page, limit, orderDirection, withExtendedInfo);
    List<dynamic> data = response.data;
    final _transfers = data.map((val) => TransferModel.fromJson(val)).toList();

    if (transfers.isEmpty) {
      transfers(_transfers);
    } else {
      print(page);
      print(currentPage.value);
      if (page != currentPage.value) {
        transfers.addAll(_transfers);
      }
    }
  }
}
