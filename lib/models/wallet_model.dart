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
  late double balance;

  @HiveField(6)
  late double totalStake;

  @HiveField(7)
  late double totalRewards;

  @HiveField(8)
  late bool isValidator;

  WalletModel(
      {required this.name,
      required this.publicKey,
      required this.accountHash,
      required this.privateKey,
      required this.isValidator});

  @override
  String toString() {
    return '$id $name $publicKey ($accountHash) $balance $totalStake $totalRewards';
  }
}
