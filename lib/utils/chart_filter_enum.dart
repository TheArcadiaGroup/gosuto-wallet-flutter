import 'package:get/get.dart';

enum ChartFilterEnum { day_1, day_7, day_14, day_21, day_30, day_180, day_365 }

extension ChartFilterEnumExtension on ChartFilterEnum {
  static const Map<ChartFilterEnum, int> _day = {
    ChartFilterEnum.day_1: 1,
    ChartFilterEnum.day_7: 7,
    ChartFilterEnum.day_14: 14,
    ChartFilterEnum.day_21: 21,
    ChartFilterEnum.day_30: 30,
    ChartFilterEnum.day_180: 180,
    ChartFilterEnum.day_365: 365
  };

  static final Map<ChartFilterEnum, String> _text = {
    ChartFilterEnum.day_1: '1_day'.tr,
    ChartFilterEnum.day_7: '1_week'.tr,
    ChartFilterEnum.day_14: '2_weeks'.tr,
    ChartFilterEnum.day_21: '3_weeks'.tr,
    ChartFilterEnum.day_30: '1_month'.tr,
    ChartFilterEnum.day_180: '6_months'.tr,
    ChartFilterEnum.day_365: '1_year'.tr
  };

  int get value => _day[this] ?? 1;
  String get key => _text[this] ?? '1_day'.tr;

// String get key {
//   switch (this) {
//     case ChartFilterEnum.day_1:
//       return '1_day'.tr;
//     case ChartFilterEnum.day_7:
//       return '1_week'.tr;
//     case ChartFilterEnum.day_14:
//       return '2_weeks'.tr;
//     case ChartFilterEnum.day_21:
//       return '3_weeks'.tr;
//     case ChartFilterEnum.day_30:
//       return '1_month'.tr;
//     case ChartFilterEnum.day_180:
//       return '6_months'.tr;
//     case ChartFilterEnum.day_365:
//       return '1_year'.tr;
//   }
// }
//
// int get value {
//   switch (this) {
//     case ChartFilterEnum.day_1:
//       return 1;
//     case ChartFilterEnum.day_7:
//       return 7;
//     case ChartFilterEnum.day_14:
//       return 14;
//     case ChartFilterEnum.day_21:
//       return 21;
//     case ChartFilterEnum.day_30:
//       return 30;
//     case ChartFilterEnum.day_180:
//       return 180;
//     case ChartFilterEnum.day_365:
//       return 365;
//   }
// }
}
