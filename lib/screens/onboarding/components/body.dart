import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gosuto/components/button.dart';
import 'package:gosuto/screens/onboarding/components/onboarding_content.dart';

import '../../../utils/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  List<Map<String, String>> pages = [
    {
      'title': 'onboarding_title1'.tr,
      'subtitle': 'onboarding_subtitle1'.tr,
    },
    {
      'title': 'onboarding_title2'.tr,
      'subtitle': 'onboarding_subtitle2'.tr,
    },
    {
      'title': 'onboarding_title3'.tr,
      'subtitle': 'onboarding_subtitle3'.tr,
    }
  ];

  void _nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.animateToPage(
        currentPage + 1,
        duration: AppConstants.duration,
        curve: Curves.easeIn,
      );
    } else {
      Get.offAllNamed('/add_wallet');
    }
  }

  void _skip() {
    Get.offAllNamed('/add_wallet');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => buildDot(index: index),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: PageView.builder(
                controller: _pageController,
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
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    GosutoButton(
                      text: currentPage < pages.length - 1
                          ? 'next'.tr
                          : 'done'.tr,
                      style: GosutoButtonStyle.fill,
                      onPressed: () {
                        _nextPage();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GosutoButton(
                      text: 'skip'.tr,
                      style: GosutoButtonStyle.text,
                      onPressed: () {
                        _skip();
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: AppConstants.duration,
      margin: const EdgeInsets.only(right: 4),
      height: 7,
      width: currentPage == index ? 14 : 7,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).colorScheme.background
            : const Color(0xffc4c4c4).withOpacity(0.35),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
