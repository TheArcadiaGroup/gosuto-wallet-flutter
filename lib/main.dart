import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/themes/theme.dart';
// import 'package:local_auth/local_auth.dart';
import 'app_binding.dart';
import 'env/env.dart';
import 'routes/app_pages.dart';

void main() async {
  await GetStorage.init();

  // final localAuth = LocalAuthentication();
  // bool canCheckBiometrics = await localAuth.canCheckBiometrics;

  String initialRoute = OnboardingService().isFirstTimeOpen
      ? Routes.onBoarding
      : Routes.addWallet;

  final _wallets = await DBHelper().getWallets();
  if (_wallets.isNotEmpty) {
    initialRoute = Routes.home;
  }

  // final _settings = await DBHelper().getSettings();
  // if (_settings.isEmpty) {
  //   initialRoute = '';
  // }

  BuildEnvironment.init(
      flavor: BuildFlavor.development,
      baseUrl: 'https://event-store-api-clarity-testnet.make.services/',
      deployHashExplorer: 'https://testnet.cspr.live/deploy/');

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);
  final String initialRoute;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      builder: EasyLoading.init(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeService().theme,
      locale: TranslationService().locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );
  }
}

void configLoading() {}
