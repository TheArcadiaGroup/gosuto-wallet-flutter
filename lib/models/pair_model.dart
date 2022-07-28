import 'package:json_annotation/json_annotation.dart';

part 'pair_model.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'contract_hash')
  late String contractHash;

  late String name;

  late String symbol;

  late int decimals;

  Token(
      {required this.contractHash,
      required this.name,
      required this.symbol,
      required this.decimals});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

@JsonSerializable()
class PairModel {
  @JsonKey(name: 'contract_package_hash')
  late String contractPackageHash;

  late Token token0;
  late Token token1;

  late String? amount0In;
  late String? amount0Out;
  late String? amount1In;
  late String? amount1Out;

  PairModel({
    required this.contractPackageHash,
    required this.token0,
    required this.token1,
    required this.amount0In,
    required this.amount0Out,
    required this.amount1In,
    required this.amount1Out,
  });

  factory PairModel.fromJson(Map<String, dynamic> json) =>
      _$PairModelFromJson(json);

  Map<String, dynamic> toJson() => _$PairModelToJson(this);
}
