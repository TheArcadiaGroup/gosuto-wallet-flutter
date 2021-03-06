import 'package:get/get.dart';

import '../../../../data/network/network.dart';
import '../../../../env/env.dart';
import '../../../../models/models.dart';

class HistoryController extends GetxController {
  var isShowBottom = false.obs;

  RxList<DeployModel> deploys = RxList<DeployModel>();
  late ApiClient apiClient;

  var currentPage = 1.obs;

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
    deploys.clear();
    super.dispose();
  }

  Future<void> getTransfers(
    String accountHash, [
    int page = 1,
    int limit = 10,
  ]) async {
    final response = await apiClient.accountDeploys(accountHash, page, limit);
    List<dynamic> data = response.data;
    final _deploys = data.map((val) => DeployModel.fromJson(val)).toList();

    if (deploys.isEmpty) {
      deploys(_deploys);
    } else {
      if (page != currentPage.value) {
        deploys.addAll(_deploys);
      }
    }
  }
}
