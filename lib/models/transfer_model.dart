import 'package:json_annotation/json_annotation.dart';

part 'transfer_model.g.dart';

@JsonSerializable()
class TransferModel {
  @JsonKey(name: 'transferId')
  String? transferId;

  @JsonKey(name: 'deployHash')
  String deployHash;

  @JsonKey(name: 'blockHash')
  String blockHash;

  @JsonKey(name: 'sourcePurse')
  String sourcePurse;

  @JsonKey(name: 'targetPurse')
  String targetPurse;

  @JsonKey(name: 'amount')
  String amount;

  @JsonKey(name: 'fromAccount')
  String fromAccount;

  @JsonKey(name: 'toAccount')
  String? toAccount;

  @JsonKey(name: 'timestamp')
  String timestamp;

  @JsonKey(name: 'fromAccountPublicKey')
  String fromAccountPublicKey;

  @JsonKey(name: 'toAccountPublicKey')
  String? toAccountPublicKey;

  TransferModel(
      {this.transferId,
      required this.deployHash,
      required this.blockHash,
      required this.sourcePurse,
      required this.targetPurse,
      required this.amount,
      required this.fromAccount,
      required this.toAccount,
      required this.timestamp,
      required this.fromAccountPublicKey,
      this.toAccountPublicKey});

  factory TransferModel.fromJson(Map<String, dynamic> json) =>
      _$TransferModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransferModelToJson(this);
}
