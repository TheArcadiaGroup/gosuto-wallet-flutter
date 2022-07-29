// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenModelAdapter extends TypeAdapter<TokenModel> {
  @override
  final int typeId = 3;

  @override
  TokenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenModel(
      contractHash: fields[0] as String,
      tokenName: fields[1] as String,
      tokenSymbol: fields[2] as String,
      tokenDecimals: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TokenModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.contractHash)
      ..writeByte(1)
      ..write(obj.tokenName)
      ..writeByte(2)
      ..write(obj.tokenSymbol)
      ..writeByte(3)
      ..write(obj.tokenDecimals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
