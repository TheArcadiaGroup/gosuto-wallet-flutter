// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deploy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryPoint _$EntryPointFromJson(Map<String, dynamic> json) => EntryPoint(
      id: json['id'] as String,
      contractHash: json['contract_hash'] as String,
      contractPackageHash: json['contract_package_hash'] as String,
      name: json['name'] as String,
      actionTypeId: json['action_type_id'] as int?,
    );

Map<String, dynamic> _$EntryPointToJson(EntryPoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contract_hash': instance.contractHash,
      'contract_package_hash': instance.contractPackageHash,
      'name': instance.name,
      'action_type_id': instance.actionTypeId,
    };

ContractPackage _$ContractPackageFromJson(Map<String, dynamic> json) =>
    ContractPackage(
      contractPackageHash: json['contract_package_hash'] as String,
      ownerPublicKey: json['owner_public_key'] as String,
      contractTypeId: json['contract_type_id'] as int?,
      contractName: json['contract_name'] as String?,
      contractDescription: json['contract_description'] as String?,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$ContractPackageToJson(ContractPackage instance) =>
    <String, dynamic>{
      'contract_package_hash': instance.contractPackageHash,
      'owner_public_key': instance.ownerPublicKey,
      'contract_type_id': instance.contractTypeId,
      'contract_name': instance.contractName,
      'contract_description': instance.contractDescription,
      'timestamp': instance.timestamp,
    };

DeployModel _$DeployModelFromJson(Map<String, dynamic> json) => DeployModel(
      deployHash: json['deploy_hash'] as String,
      blockHash: json['block_hash'] as String,
      callerPublicKey: json['caller_public_key'] as String,
      executionTypeId: json['execution_type_id'] as int,
      contractHash: json['contract_hash'] as String?,
      contractPackageHash: json['contract_package_hash'] as String?,
      cost: json['cost'] as String,
      paymentAmount: json['payment_amount'] as String,
      errorMessage: json['error_message'] as String?,
      timestamp: json['timestamp'] as String,
      status: json['status'] as String,
      amount: json['amount'] as String?,
      entryPoint: json['entry_point'] == null
          ? null
          : EntryPoint.fromJson(json['entry_point'] as Map<String, dynamic>),
      contractPackage: json['contract_package'] == null
          ? null
          : ContractPackage.fromJson(
              json['contract_package'] as Map<String, dynamic>),
      currencyCost: (json['currency_cost'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
      currentCurrencyCost: (json['current_currency_cost'] as num?)?.toDouble(),
      pair: json['pair'] == null
          ? null
          : PairModel.fromJson(json['pair'] as Map<String, dynamic>),
    )..args = json['args'];

Map<String, dynamic> _$DeployModelToJson(DeployModel instance) =>
    <String, dynamic>{
      'deploy_hash': instance.deployHash,
      'block_hash': instance.blockHash,
      'caller_public_key': instance.callerPublicKey,
      'execution_type_id': instance.executionTypeId,
      'contract_hash': instance.contractHash,
      'contract_package_hash': instance.contractPackageHash,
      'cost': instance.cost,
      'payment_amount': instance.paymentAmount,
      'error_message': instance.errorMessage,
      'timestamp': instance.timestamp,
      'status': instance.status,
      'amount': instance.amount,
      'entry_point': instance.entryPoint,
      'contract_package': instance.contractPackage,
      'currency_cost': instance.currencyCost,
      'rate': instance.rate,
      'current_currency_cost': instance.currentCurrencyCost,
      'args': instance.args,
      'pair': instance.pair,
    };
