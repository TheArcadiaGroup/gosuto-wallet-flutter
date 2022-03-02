import 'package:flutter/material.dart';
import 'package:gosuto_wallet_flutter/constants.dart';
import 'package:gosuto_wallet_flutter/screens/onboarding/components/body.dart';

import '../../size_config.dart';

class OnboardingScreen extends StatelessWidget {
  static String routeName = '/onboarding';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
      backgroundColor: darkBackgroundClor,
    );
  }
}
