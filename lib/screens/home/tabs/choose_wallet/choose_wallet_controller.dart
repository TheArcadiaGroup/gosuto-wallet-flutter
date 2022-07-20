import 'package:get/get.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/models.dart';

class ChooseWalletController extends GetxController {
  List<WalletModel> wallets = <WalletModel>[].obs;

  Future fetchData() async {
    final _walletsDB = await DBHelper().getWallets();
    final _wallets = _walletsDB.values.toList();
    _wallets.sort((a, b) => a.id.compareTo(b.id));
    wallets.assignAll(_wallets);
  }
}
