import 'package:get/get.dart';

enum ChartFilterEnum { day_1, day_7, day_14, day_30, day_60, day_180, day_365 }

extension ChartFilterEnumExtension on ChartFilterEnum {
  static const Map<ChartFilterEnum, int> _day = {
    ChartFilterEnum.day_1: 1,
    ChartFilterEnum.day_7: 7,
    ChartFilterEnum.day_14: 14,
    ChartFilterEnum.day_30: 30,
    ChartFilterEnum.day_60: 60,
    ChartFilterEnum.day_180: 200,
    ChartFilterEnum.day_365: 365
  };

  static final Map<ChartFilterEnum, String> _text = {
    ChartFilterEnum.day_1: '1_day'.tr,
    ChartFilterEnum.day_7: '1_week'.tr,
    ChartFilterEnum.day_14: '2_weeks'.tr,
    ChartFilterEnum.day_30: '1_month'.tr,
    ChartFilterEnum.day_60: '2_month'.tr,
    ChartFilterEnum.day_180: '6_months'.tr,
    ChartFilterEnum.day_365: '1_year'.tr
  };

  int get value => _day[this] ?? 1;

  String get key => _text[this] ?? '1_day'.tr;
}
