import 'package:flutter/material.dart';
import 'package:gosuto_wallet_flutter/main.dart';
import 'package:gosuto_wallet_flutter/size_config.dart';

import '../../../constants.dart';

class OnboardingContent extends StatelessWidget {
  final String title, subtitle;

  const OnboardingContent({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(30),
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: darkTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 16,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: darkMutedTextColor,
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
