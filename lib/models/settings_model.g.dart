// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 2;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      seedPhrase: fields[0] as String,
      password: fields[1] as String,
      useBiometricAuth: fields[2] as int,
    )..lastUpdatedTimestamp = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.seedPhrase)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.useBiometricAuth)
      ..writeByte(3)
      ..write(obj.lastUpdatedTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
