// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferModel _$TransferModelFromJson(Map<String, dynamic> json) =>
    TransferModel(
      transferId: json['transferId'] as String?,
      deployHash: json['deployHash'] as String,
      blockHash: json['blockHash'] as String,
      sourcePurse: json['sourcePurse'] as String,
      targetPurse: json['targetPurse'] as String,
      amount: json['amount'] as String,
      fromAccount: json['fromAccount'] as String,
      toAccount: json['toAccount'] as String,
      timestamp: json['timestamp'] as String,
      fromAccountPublicKey: json['fromAccountPublicKey'] as String,
      toAccountPublicKey: json['toAccountPublicKey'] as String?,
    );

Map<String, dynamic> _$TransferModelToJson(TransferModel instance) =>
    <String, dynamic>{
      'transferId': instance.transferId,
      'deployHash': instance.deployHash,
      'blockHash': instance.blockHash,
      'sourcePurse': instance.sourcePurse,
      'targetPurse': instance.targetPurse,
      'amount': instance.amount,
      'fromAccount': instance.fromAccount,
      'toAccount': instance.toAccount,
      'timestamp': instance.timestamp,
      'fromAccountPublicKey': instance.fromAccountPublicKey,
      'toAccountPublicKey': instance.toAccountPublicKey,
    };
