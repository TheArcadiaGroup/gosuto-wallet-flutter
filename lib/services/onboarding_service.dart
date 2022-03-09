import 'package:get_storage/get_storage.dart';

class OnboardingService {
  final _key = 'isFirstTimeOpen';
  final _box = GetStorage();

  bool get isFirstTimeOpen => _box.read(_key) ?? true;

  setFirstTimeOpen() => _box.write(_key, false);
}
