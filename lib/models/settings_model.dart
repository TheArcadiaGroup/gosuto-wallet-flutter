import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 2)
class SettingsModel {
  @HiveField(0)
  late String seedPhrase;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late int useBiometricAuth;

  SettingsModel({
    required this.seedPhrase,
    required this.password,
    required this.useBiometricAuth,
  });
}
