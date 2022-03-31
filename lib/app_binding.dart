import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'data/network/network.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<Dio>(DioBase.instance);
  }
}
