import 'package:get/get.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/wallet.dart';

class ChooseWalletController extends GetxController {
  List<Wallet> wallets = <Wallet>[].obs;

  Future fetchData() async {
    final _wallets = await DBHelper().getWallets();
    wallets.assignAll(_wallets);
  }
}
