import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var initialRoute = OnboardingService().isFirstTimeOpen
        ? Routes.onboarding
        : Routes.addWallet;

    print(OnboardingService().isFirstTimeOpen);

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
