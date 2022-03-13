import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).hintColor,
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
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
