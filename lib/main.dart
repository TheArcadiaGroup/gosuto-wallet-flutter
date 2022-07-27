import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/models.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/themes/theme.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:local_auth/local_auth.dart';
import 'app_binding.dart';
import 'env/env.dart';
import 'routes/app_pages.dart';

Future<void> config() async {
  // BuildEnvironment.init(
  //     flavor: BuildFlavor.development,
  //     rpcUrl: 'https://testnet.casper-node.tor.us',
  //     baseUrl: 'https://event-store-api-clarity-testnet.make.services/',
  //     deployHashExplorer: 'https://testnet.cspr.live/deploy/');

  BuildEnvironment.init(
      flavor: BuildFlavor.development,
      rpcUrl: 'https://casper-node.tor.us',
      baseUrl: 'https://event-store-api-clarity-mainnet.make.services/',
      deployHashExplorer: 'https://cspr.live/deploy/');

  const secureStorage = FlutterSecureStorage();
  // if key not exists return null
  final encryprionKey = await secureStorage.read(key: 'gosuto');
  if (encryprionKey == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'gosuto',
      value: base64UrlEncode(key),
    );
  }

  // Get balance after every 10 mins
  Timer.periodic(const Duration(minutes: 10), (Timer t) async {
    await AccountUtils.getAllBalances(false);
  });

  var themeService = ThemeService();

  EasyLoading.instance
    ..indicatorSize = 25.0
    ..backgroundColor = themeService.isDarkMode
        ? AppTheme.darkTheme.colorScheme.onPrimary
        : AppTheme.lightTheme.colorScheme.onPrimary
    ..indicatorColor = AppTheme.darkTheme.colorScheme.background
    ..indicatorType = EasyLoadingIndicatorType.fadingFour;
}

void main() async {
  await GetStorage.init();

  await Hive.initFlutter();
  Hive
    ..registerAdapter(WalletModelAdapter())
    ..registerAdapter(SettingsModelAdapter());

  String initialRoute = OnboardingService().isFirstTimeOpen
      ? Routes.onBoarding
      : Routes.addWallet;

  final _wallets = await DBHelper.getWallets();
  if (_wallets.isNotEmpty) {
    initialRoute = Routes.home;
  }

  await DBHelper.addSettings(
      SettingsModel(seedPhrase: '', password: '', useBiometricAuth: 0));

  await config();

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
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
