// ignore_for_file: file_names

class Wallet {
  late String walletName;
  late String password;
  late String publicKey;
  late String accountHash;
  late String cipherText;

  Wallet({
    required this.walletName,
    required this.password,
    required this.publicKey,
    required this.accountHash,
    required this.cipherText,
  });

  Map<String, dynamic> toMap() {
    return {
      'walletName': walletName,
      'password': password,
      'publicKey': publicKey,
      'accountHash': accountHash,
      'cipherText': cipherText,
    };
  }

  Wallet.fromMap(Map<String, dynamic> map) {
    walletName = map['walletName'];
    password = map['password'];
    publicKey = map['publicKey'];
    accountHash = map['accountHash'];
    cipherText = map['cipherText'];
  }
}
