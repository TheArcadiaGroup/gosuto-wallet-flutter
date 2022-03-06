import 'package:get/get.dart';
import 'package:gosuto/pages/home/home.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
    // GetPage(
    //     name: Routes.wallet_home,
    //     page: () => const WalletHomeTab(),
    //     binding: WalletHomeBinding())
  ];
}
