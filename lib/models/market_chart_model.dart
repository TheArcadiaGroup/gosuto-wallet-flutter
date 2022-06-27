import 'package:json_annotation/json_annotation.dart';

part 'market_chart_model.g.dart';

@JsonSerializable()
class MarketChartModel {
  MarketChartModel(this.prices, this.marketCaps, this.totalVolumes);

  factory MarketChartModel.fromJson(Map<String, dynamic> json) =>
      _$MarketChartModelFromJson(json);

  @JsonKey(name: 'prices')
  List<List> prices;

  @JsonKey(name: 'market_caps')
  List marketCaps;

  @JsonKey(name: 'total_volumes')
  List totalVolumes;

  Map<String, dynamic> toJson() => _$MarketChartModelToJson(this);
}
