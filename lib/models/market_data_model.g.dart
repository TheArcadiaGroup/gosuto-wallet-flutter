// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketDataModel _$MarketDataModelFromJson(Map<String, dynamic> json) =>
    MarketDataModel(
      CurrentPriceModel.fromJson(json['current_price'] as Map<String, dynamic>),
      (json['price_change_percentage_24h'] as num).toDouble(),
      (json['price_change_percentage_7d'] as num).toDouble(),
      (json['price_change_percentage_14d'] as num).toDouble(),
      (json['price_change_percentage_30d'] as num).toDouble(),
      (json['price_change_percentage_60d'] as num).toDouble(),
      (json['price_change_percentage_200d'] as num).toDouble(),
      (json['price_change_percentage_1y'] as num).toDouble(),
    );

Map<String, dynamic> _$MarketDataModelToJson(MarketDataModel instance) =>
    <String, dynamic>{
      'current_price': instance.currentPrice,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
      'price_change_percentage_7d': instance.priceChangePercentage7d,
      'price_change_percentage_14d': instance.priceChangePercentage14d,
      'price_change_percentage_30d': instance.priceChangePercentage30d,
      'price_change_percentage_60d': instance.priceChangePercentage60d,
      'price_change_percentage_200d': instance.priceChangePercentage200d,
      'price_change_percentage_1y': instance.priceChangePercentage1y,
    };
