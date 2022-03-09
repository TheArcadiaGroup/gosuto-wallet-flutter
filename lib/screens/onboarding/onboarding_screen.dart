import 'package:flutter/material.dart';
import 'package:gosuto/screens/onboarding/components/body.dart';
import 'package:gosuto/services/service.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnboardingService().setFirstTimeOpen();

    return const Scaffold(
      body: Body(),
    );
  }
}
