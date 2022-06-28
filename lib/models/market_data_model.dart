import 'package:json_annotation/json_annotation.dart';

import 'current_price_model.dart';

part 'market_data_model.g.dart';

@JsonSerializable()
class MarketDataModel {
  MarketDataModel(
      this.currentPrice,
      this.priceChangePercentage24h,
      this.priceChangePercentage7d,
      this.priceChangePercentage14d,
      this.priceChangePercentage30d,
      this.priceChangePercentage60d,
      this.priceChangePercentage200d,
      this.priceChangePercentage1y);

  factory MarketDataModel.fromJson(Map<String, dynamic> json) =>
      _$MarketDataModelFromJson(json);

  @JsonKey(name: 'current_price')
  CurrentPriceModel currentPrice;

  @JsonKey(name: 'price_change_percentage_24h')
  double priceChangePercentage24h;

  @JsonKey(name: 'price_change_percentage_7d')
  double priceChangePercentage7d;

  @JsonKey(name: 'price_change_percentage_14d')
  double priceChangePercentage14d;

  @JsonKey(name: 'price_change_percentage_30d')
  double priceChangePercentage30d;

  @JsonKey(name: 'price_change_percentage_60d')
  double priceChangePercentage60d;

  @JsonKey(name: 'price_change_percentage_200d')
  double priceChangePercentage200d;

  @JsonKey(name: 'price_change_percentage_1y')
  double priceChangePercentage1y;

  Map<String, dynamic> toJson() => _$MarketDataModelToJson(this);
}
