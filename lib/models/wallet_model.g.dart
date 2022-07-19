// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
      json['walletName'] as String,
      json['publicKey'] as String,
      json['accountHash'] as String,
      json['privateKey'] as String,
      json['isValidator'] as int,
    )..id = json['id'] as int?;

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'walletName': instance.walletName,
      'publicKey': instance.publicKey,
      'accountHash': instance.accountHash,
      'privateKey': instance.privateKey,
      'isValidator': instance.isValidator,
    };
