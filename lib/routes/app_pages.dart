import 'package:get/get.dart';
import 'package:gosuto/screens/create_wallet/create_wallet.dart';
import 'package:gosuto/screens/home/home.dart';
import 'package:gosuto/screens/import_seed/import_seed.dart';
import 'package:gosuto/screens/onboarding/onboarding_screen.dart';
import 'package:gosuto/screens/add_wallet/add_wallet.dart';
import 'package:gosuto/screens/seed_phrase/seed_phrase.dart';
import '../screens/confirm_seed_phrase/confirm_seed_phrase.dart';

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
    ),
    GetPage(
      name: Routes.addWallet,
      page: () => const AddWalletScreen(),
      binding: AddWalletBinding(),
    ),
    GetPage(
      name: Routes.seedPhrase,
      page: () => const SeedPhraseScreen(),
      binding: SeedPhraseBinding(),
    ),
    GetPage(
      name: Routes.confirmSeedPhrase,
      page: () => const ConfirmSeedPhraseScreen(),
      binding: ConfirmSeedPhraseBinding(),
    ),
    GetPage(
      name: Routes.createWallet,
      page: () => const CreateWalletScreen(),
      binding: CreateWalletBinding(),
    ),
    GetPage(
      name: Routes.importSeed,
      page: () => const ImportSeedScreen(),
      binding: ImportSeedBinding(),
    ),
  ];
}
