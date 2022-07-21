// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_cache_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RPCCacheModelAdapter extends TypeAdapter<RPCCacheModel> {
  @override
  final int typeId = 3;

  @override
  RPCCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RPCCacheModel(
      balance: (fields[0] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      lastTimestamp: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RPCCacheModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.lastTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RPCCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
