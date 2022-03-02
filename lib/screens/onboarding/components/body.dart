import 'package:flutter/material.dart';
import 'package:gosuto_wallet_flutter/constants.dart';
import 'package:gosuto_wallet_flutter/screens/onboarding/components/onboarding_content.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  List<Map<String, String>> pages = [
    {
      'title': 'Welcome to Gosuto Wallet',
      'subtitle':
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
    },
    {
      'title': 'Lorem ipsum dolor sit amet, consectetuer adipiscing',
      'subtitle':
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
    },
    {
      'title': 'Lorem ipsum dolor sit amet, consectetuer adipiscing',
      'subtitle':
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => buildDot(index: index),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Expanded(
              flex: 1,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) => OnboardingContent(
                  title: pages[index]['title'].toString(),
                  subtitle: pages[index]['subtitle'].toString(),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: const EdgeInsets.only(right: 4),
      height: 7,
      width: currentPage == index ? 14 : 7,
      decoration: BoxDecoration(
        color: currentPage == index ? primaryColor : const Color(0xffc4c4c4),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
