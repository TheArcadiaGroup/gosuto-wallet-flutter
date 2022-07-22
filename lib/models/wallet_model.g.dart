// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletModelAdapter extends TypeAdapter<WalletModel> {
  @override
  final int typeId = 1;

  @override
  WalletModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletModel(
      name: fields[1] as String,
      publicKey: fields[2] as String,
      accountHash: fields[3] as String,
      privateKey: fields[4] as String,
      isValidator: fields[8] as bool,
    )
      ..id = fields[0] as int
      ..balance = fields[5] as double
      ..totalStake = fields[6] as double
      ..totalRewards = fields[7] as double;
  }

  @override
  void write(BinaryWriter writer, WalletModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.publicKey)
      ..writeByte(3)
      ..write(obj.accountHash)
      ..writeByte(4)
      ..write(obj.privateKey)
      ..writeByte(5)
      ..write(obj.balance)
      ..writeByte(6)
      ..write(obj.totalStake)
      ..writeByte(7)
      ..write(obj.totalRewards)
      ..writeByte(8)
      ..write(obj.isValidator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
