// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketChartModel _$MarketChartModelFromJson(Map<String, dynamic> json) =>
    MarketChartModel(
      (json['prices'] as List<dynamic>).map((e) => e as List<dynamic>).toList(),
      json['market_caps'] as List<dynamic>,
      json['total_volumes'] as List<dynamic>,
    );

Map<String, dynamic> _$MarketChartModelToJson(MarketChartModel instance) =>
    <String, dynamic>{
      'prices': instance.prices,
      'market_caps': instance.marketCaps,
      'total_volumes': instance.totalVolumes,
    };
