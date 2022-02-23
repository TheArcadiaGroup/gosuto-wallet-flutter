import 'package:flutter/material.dart';
import 'package:gosuto_wallet_flutter/theme/colors.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnBoardingPage();
}

class _OnBoardingPage extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {}

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: GotusoColors.darkblue,
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => _onIntroEnd(context),
      next: const Icon(Icons.arrow_forward),
      pages: [
        PageViewModel(
          title: 'Lorem ipsum dolor sit amet, consectetuer adipiscing',
          body:
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
          image: Image.asset('assets/images/onboarding1.png'),
        ),
        PageViewModel(
          title: 'Lorem ipsum dolor sit amet, consectetuer adipiscing',
          body:
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
          image: Image.asset('assets/images/onboarding2.png'),
        ),
        PageViewModel(
          title: 'Lorem ipsum dolor sit amet, consectetuer adipiscing',
          body:
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
          image: Image.asset('assets/images/onboarding3.png'),
        ),
      ],
    );
  }
}
