class Wallet {
  int? id;
  late String walletName;
  late String publicKey;
  late String accountHash;
  late String privateKey;

  Wallet({
    required this.walletName,
    required this.publicKey,
    required this.accountHash,
    required this.privateKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'walletName': walletName,
      'publicKey': publicKey,
      'accountHash': accountHash,
      'privateKey': privateKey,
    };
  }

  Wallet.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    walletName = map['walletName'];
    publicKey = map['publicKey'];
    accountHash = map['accountHash'];
    privateKey = map['privateKey'];
  }
}
