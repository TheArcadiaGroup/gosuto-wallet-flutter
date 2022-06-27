// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'casper_network_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CasperNetworkModel _$CasperNetworkModelFromJson(Map<String, dynamic> json) =>
    CasperNetworkModel(
      MarketDataModel.fromJson(json['market_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CasperNetworkModelToJson(CasperNetworkModel instance) =>
    <String, dynamic>{
      'market_data': instance.marketData,
    };
