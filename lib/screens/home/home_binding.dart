import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../data/network/network.dart';
import 'home.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<HomeController>(() => HomeController())
      ..lazyPut<Dio>(DioBase.instance);
  }
}
