import 'package:get/get.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/models.dart';

class ChooseWalletController extends GetxController {
  List<WalletModel> wallets = <WalletModel>[].obs;

  Future fetchData() async {
    final _wallets = await DBHelper().getWallets();
    // print(_wallets[0].toMap());
    wallets.assignAll(_wallets);
  }
}
