import 'package:flutter/material.dart';
import 'package:gosuto_wallet_flutter/screens/onboarding/components/onboarding_content.dart';

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
            Expanded(
              flex: 3,
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
          ],
        ),
      ),
    );
  }
}
