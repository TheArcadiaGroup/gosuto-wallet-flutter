import 'package:json_annotation/json_annotation.dart';

import 'current_price_model.dart';

part 'market_data_model.g.dart';

@JsonSerializable()
class MarketDataModel {
  MarketDataModel(this.currentPrice, this.priceChangePercentage24h);

  factory MarketDataModel.fromJson(Map<String, dynamic> json) =>
      _$MarketDataModelFromJson(json);

  @JsonKey(name: 'current_price')
  CurrentPriceModel currentPrice;

  @JsonKey(name: 'price_change_percentage_24h')
  double priceChangePercentage24h;

  Map<String, dynamic> toJson() => _$MarketDataModelToJson(this);
}
