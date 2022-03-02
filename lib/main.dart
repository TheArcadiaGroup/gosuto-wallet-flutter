import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:gosuto_wallet_flutter/onboarding.dart';
import 'package:gosuto_wallet_flutter/routes.dart';
import 'package:gosuto_wallet_flutter/screens/onboarding/onboarding_screen.dart';
import 'package:gosuto_wallet_flutter/theme.dart';

void main() {
  runApp(const GosutoWalletApp());
}

class GosutoWalletApp extends StatelessWidget {
  const GosutoWalletApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Gotuso Wallet',
      theme: theme(),
      initialRoute: OnboardingScreen.routeName,
      routes: routes,
    );
  }
}
