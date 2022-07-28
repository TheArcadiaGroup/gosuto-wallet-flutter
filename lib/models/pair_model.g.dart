// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pair_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      contractHash: json['contract_hash'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimals: json['decimals'] as int,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'contract_hash': instance.contractHash,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
    };

PairModel _$PairModelFromJson(Map<String, dynamic> json) => PairModel(
      contractPackageHash: json['contract_package_hash'] as String,
      token0: Token.fromJson(json['token0'] as Map<String, dynamic>),
      token1: Token.fromJson(json['token1'] as Map<String, dynamic>),
      amount0In: json['amount0In'] as String?,
      amount0Out: json['amount0Out'] as String?,
      amount1In: json['amount1In'] as String?,
      amount1Out: json['amount1Out'] as String?,
    );

Map<String, dynamic> _$PairModelToJson(PairModel instance) => <String, dynamic>{
      'contract_package_hash': instance.contractPackageHash,
      'token0': instance.token0,
      'token1': instance.token1,
      'amount0In': instance.amount0In,
      'amount0Out': instance.amount0Out,
      'amount1In': instance.amount1In,
      'amount1Out': instance.amount1Out,
    };
