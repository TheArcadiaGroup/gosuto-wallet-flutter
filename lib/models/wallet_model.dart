import 'package:hive/hive.dart';

part 'wallet_model.g.dart';

@HiveType(typeId: 1)
class WalletModel {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String publicKey;

  @HiveField(3)
  late String accountHash;

  @HiveField(4)
  late String privateKey;

  @HiveField(5)
  late bool isValidator;

  WalletModel(
      {required this.name,
      required this.publicKey,
      required this.accountHash,
      required this.privateKey,
      required this.isValidator});
}
