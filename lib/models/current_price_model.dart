import 'package:json_annotation/json_annotation.dart';

part 'current_price_model.g.dart';

@JsonSerializable()
class CurrentPriceModel {
  CurrentPriceModel(this.usd, this.eur);

  factory CurrentPriceModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentPriceModelFromJson(json);

  @JsonKey(name: 'usd')
  double usd;

  @JsonKey(name: 'eur')
  double eur;

  Map<String, dynamic> toJson() => _$CurrentPriceModelToJson(this);
}
