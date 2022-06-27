// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketDataModel _$MarketDataModelFromJson(Map<String, dynamic> json) =>
    MarketDataModel(
      CurrentPriceModel.fromJson(json['current_price'] as Map<String, dynamic>),
      (json['price_change_percentage_24h'] as num).toDouble(),
    );

Map<String, dynamic> _$MarketDataModelToJson(MarketDataModel instance) =>
    <String, dynamic>{
      'current_price': instance.currentPrice,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
    };
