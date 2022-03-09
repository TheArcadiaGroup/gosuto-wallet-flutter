import 'package:get/get.dart';
import 'package:gosuto/screens/home/home.dart';
import 'package:gosuto/screens/onboarding/onboarding_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingScreen(),
    )
    // GetPage(
    //     name: Routes.wallet_home,
    //     page: () => const WalletHomeTab(),
    //     binding: WalletHomeBinding())
  ];
}
