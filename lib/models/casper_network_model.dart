import 'package:json_annotation/json_annotation.dart';

import 'market_data_model.dart';

part 'casper_network_model.g.dart';

@JsonSerializable()
class CasperNetworkModel {
  CasperNetworkModel(this.marketData);

  factory CasperNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$CasperNetworkModelFromJson(json);

  @JsonKey(name: 'market_data')
  MarketDataModel marketData;

  Map<String, dynamic> toJson() => _$CasperNetworkModelToJson(this);
}
