import 'package:hive/hive.dart';

part 'token_model.g.dart';

@HiveType(typeId: 3)
class TokenModel {
  @HiveField(0)
  late String contractHash;

  @HiveField(1)
  late String tokenName;

  @HiveField(2)
  late String tokenSymbol;

  @HiveField(3)
  late int tokenDecimals;

  TokenModel({
    required this.contractHash,
    required this.tokenName,
    required this.tokenSymbol,
    required this.tokenDecimals,
  });

  @override
  String toString() {
    return 'TokenModel: contractHash: $contractHash, tokenName $tokenName, tokenSymbol $tokenSymbol, tokenDecimals $tokenDecimals';
  }
}
