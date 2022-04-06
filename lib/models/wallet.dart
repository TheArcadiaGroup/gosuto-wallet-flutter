// ignore_for_file: file_names

class Wallet {
  int? id;
  late String walletName;
  late String password;
  late String publicKey;
  late String accountHash;
  late String seedPhrase;
  late String privateKey;

  Wallet({
    required this.walletName,
    required this.password,
    required this.publicKey,
    required this.accountHash,
    required this.seedPhrase,
    required this.privateKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'walletName': walletName,
      'password': password,
      'publicKey': publicKey,
      'accountHash': accountHash,
      'seedPhrase': seedPhrase,
      'privateKey': privateKey,
    };
  }

  Wallet.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    walletName = map['walletName'];
    password = map['password'];
    publicKey = map['publicKey'];
    accountHash = map['accountHash'];
    seedPhrase = map['seedPhrase'];
    privateKey = map['privateKey'];
  }
}
