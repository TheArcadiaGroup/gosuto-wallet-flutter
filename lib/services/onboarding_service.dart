import 'package:get_storage/get_storage.dart';

class OnboardingService {
  final _key = 'isFirstTimeOpen';
  final _box = GetStorage();

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
