import 'package:hive/hive.dart';

part 'rpc_cache_model.g.dart';

@HiveType(typeId: 3)
class RPCCacheModel {
  @HiveField(0)
  late List<Map<String, dynamic>> balance;

  @HiveField(1)
  late int lastTimestamp;

  RPCCacheModel({required this.balance, required this.lastTimestamp});

  @override
  String toString() {
    return 'Cache: ' + lastTimestamp.toString();
  }
}
