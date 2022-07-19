import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class WalletModel {
  int? id;
  late String walletName;
  late String publicKey;
  late String accountHash;
  late String privateKey;
  late int isValidator;

  WalletModel(this.walletName, this.publicKey, this.accountHash,
      this.privateKey, this.isValidator);

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}
