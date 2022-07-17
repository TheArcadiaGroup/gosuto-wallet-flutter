import 'package:get_storage/get_storage.dart';

class CoinService {
  final _box = GetStorage();
  final _key = 'coin';

  String get coin => _loadThemeFromBox();

  void switchCoin(String coin) {
    _saveCoinToBox(coin);
  }

  String _loadThemeFromBox() => _box.read(_key) ?? 'USD';

  _saveCoinToBox(String coin) => _box.write(_key, coin);
}
