// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      json['seedPhrase'] as String,
      json['password'] as String,
      json['useBiometricAuth'] as int,
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'seedPhrase': instance.seedPhrase,
      'password': instance.password,
      'useBiometricAuth': instance.useBiometricAuth,
    };
