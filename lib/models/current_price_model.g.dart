// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentPriceModel _$CurrentPriceModelFromJson(Map<String, dynamic> json) =>
    CurrentPriceModel(
      (json['usd'] as num).toDouble(),
      (json['eur'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentPriceModelToJson(CurrentPriceModel instance) =>
    <String, dynamic>{
      'usd': instance.usd,
      'eur': instance.eur,
    };
