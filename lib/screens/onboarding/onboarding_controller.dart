import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final _box = GetStorage();
  final _key = 'isFirstTimeOpen';

  bool get isFirstTimeOpen {
    if (_box.read(_key) == null) {
      return true;
    }
    return _box.read(_key);
  }

  setFirstTimeOpen() {
    _box.write(_key, false);
  }
}
