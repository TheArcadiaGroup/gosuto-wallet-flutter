import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'stake.dart';

class StakeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var currentTab = StakeTabs.all.obs;
  var isShowBottom = false.obs;
  late CarouselController carouselController;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    carouselController = CarouselController();
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(StakeTabs tab) {
    switch (tab) {
      case StakeTabs.all:
        return 0;
      case StakeTabs.validators:
        return 1;
      default:
        return 0;
    }
  }

  StakeTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return StakeTabs.all;
      case 1:
        return StakeTabs.validators;
      default:
        return StakeTabs.validators;
    }
  }
}
