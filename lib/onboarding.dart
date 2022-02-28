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

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      height: 1.56,
    );
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      titlePadding: EdgeInsets.only(top: 250, bottom: 10),
      bodyAlignment: Alignment.center,
      bodyTextStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        height: 1.56,
      ),
      bodyPadding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: GotusoColors.background,
      globalFooter: Column(
        children: const <Widget>[
          ElevatedButton(
            onPressed: null,
            child: Text('Next'),
          )
        ],
      ),
      showDoneButton: false,
      showNextButton: false,
      pages: [
        PageViewModel(
          title: 'Lorem ipsum dolor sit amet, consectetuer adipiscing',
          body:
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Lorem ipsum dolor sit amet, consectetuer adipiscing',
          body:
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Lorem ipsum dolor sit amet, consectetuer adipiscing',
          body:
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
          decoration: pageDecoration,
        ),
      ],
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xffdbdbdb),
        activeSize: Size(22.0, 10.0),
        activeColor: GotusoColors.orange,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
