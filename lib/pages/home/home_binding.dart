import 'package:get/get.dart';
import 'package:gosuto/pages/home/home.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
