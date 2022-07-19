import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  late String seedPhrase;
  late String password;
  late int useBiometricAuth;

  SettingsModel(
    this.seedPhrase,
    this.password,
    this.useBiometricAuth,
  );

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}
