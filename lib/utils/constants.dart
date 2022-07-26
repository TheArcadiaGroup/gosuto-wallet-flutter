import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';
import '../themes/colors.dart';

class AppConstants {
  static const duration = Duration(milliseconds: 200);
  static final coins = ['USD', 'EUR'];

  static final chartFilterItems = [
    '1_day'.tr,
    '1_week'.tr,
    '2_weeks'.tr,
    '3_weeks'.tr,
    '1_month'.tr,
    '6_months'.tr,
    '1_year'.tr,
  ];

  static final historyFilterItems = [
    'all'.tr,
    'sent'.tr,
    'received'.tr,
    'contract_interaction'.tr,
  ];

  static final TextStyle subTextStyle = TextStyle(
      fontSize: 12,
      height: 2,
      color: ThemeService().isDarkMode
          ? AppDarkColors.textColor1
          : const Color(0xFFA1A1A1));

  static InputDecoration getInputDecoration(context) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
      contentPadding: const EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    );
  }

  static const double heightBottomView = 90;
  static const double maxHeightSlidingUpPanel = 650;
}
