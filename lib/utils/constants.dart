import 'package:get/get.dart';

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
    'received'.tr,
    'sent'.tr,
    'swap'.tr,
    'staking'.tr,
  ];
}
