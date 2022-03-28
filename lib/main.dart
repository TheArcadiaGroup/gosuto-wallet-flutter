import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/wallet.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/themes/theme.dart';
import 'app_binding.dart';
import 'routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(const GosutoWalletApp());
  configLoading();
}

class GosutoWalletApp extends StatefulWidget {
  const GosutoWalletApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GosutoWalletAppState();
  }
}

class GosutoWalletAppState extends State<GosutoWalletApp> {
  int walletCount = 0;
  String initialRoute = OnboardingService().isFirstTimeOpen
      ? Routes.onboarding
      : Routes.addWallet;

  Future _countWallet() async {
    walletCount = (await DBHelper().getAllWallets()).length;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _countWallet(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }

        initialRoute = walletCount > 0 ? Routes.home : Routes.addWallet;

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
      }),
    );
  }
}

void configLoading() {}
