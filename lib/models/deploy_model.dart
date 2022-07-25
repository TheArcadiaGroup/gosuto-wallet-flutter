import 'package:json_annotation/json_annotation.dart';

part 'deploy_model.g.dart';

@JsonSerializable()
class EntryPoint {
  String id;

  @JsonKey(name: 'contract_hash')
  String contractHash;

  @JsonKey(name: 'contract_package_hash')
  String contractPackageHash;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'action_type_id')
  int? actionTypeId;

  EntryPoint({
    required this.id,
    required this.contractHash,
    required this.contractPackageHash,
    required this.name,
    this.actionTypeId,
  });

  factory EntryPoint.fromJson(Map<String, dynamic> json) =>
      _$EntryPointFromJson(json);

  Map<String, dynamic> toJson() => _$EntryPointToJson(this);
}

@JsonSerializable()
class ContractPackage {
  @JsonKey(name: 'contract_package_hash')
  String contractPackageHash;

  @JsonKey(name: 'owner_public_key')
  String ownerPublicKey;

  @JsonKey(name: 'contract_type_id')
  int? contractTypeId;

  @JsonKey(name: 'contract_name')
  String? contractName;

  @JsonKey(name: 'contract_description')
  String? contractDescription;

  @JsonKey(name: 'timestamp')
  String timestamp;

  ContractPackage({
    required this.contractPackageHash,
    required this.ownerPublicKey,
    this.contractTypeId,
    this.contractName,
    this.contractDescription,
    required this.timestamp,
  });

  factory ContractPackage.fromJson(Map<String, dynamic> json) =>
      _$ContractPackageFromJson(json);

  Map<String, dynamic> toJson() => _$ContractPackageToJson(this);
}

@JsonSerializable()
class DeployModel {
  @JsonKey(name: 'deploy_hash')
  String deployHash;

  @JsonKey(name: 'block_hash')
  String blockHash;

  @JsonKey(name: 'caller_public_key')
  String callerPublicKey;

  @JsonKey(name: 'execution_type_id')
  int executionTypeId;

  @JsonKey(name: 'contract_hash')
  String? contractHash;

  @JsonKey(name: 'contract_package_hash')
  String? contractPackageHash;

  @JsonKey(name: 'cost')
  String cost;

  @JsonKey(name: 'payment_amount')
  String paymentAmount;

  @JsonKey(name: 'error_message')
  String? errorMssage;

  @JsonKey(name: 'timestamp')
  String timestamp;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'amount')
  String? amount;

  @JsonKey(name: 'entry_point')
  EntryPoint? entryPoint;

  @JsonKey(name: 'contract_package')
  ContractPackage? contractPackage;

  @JsonKey(name: 'currency_cost')
  double currencyCost;

  @JsonKey(name: 'rate')
  double rate;

  @JsonKey(name: 'current_currency_cost')
  double currentCurrencyCost;

  DeployModel({
    required this.deployHash,
    required this.blockHash,
    required this.callerPublicKey,
    required this.executionTypeId,
    this.contractHash,
    this.contractPackageHash,
    required this.cost,
    required this.paymentAmount,
    this.errorMssage,
    required this.timestamp,
    required this.status,
    this.amount,
    this.entryPoint,
    this.contractPackage,
    required this.currencyCost,
    required this.rate,
    required this.currentCurrencyCost,
  });

  factory DeployModel.fromJson(Map<String, dynamic> json) =>
      _$DeployModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeployModelToJson(this);
}
