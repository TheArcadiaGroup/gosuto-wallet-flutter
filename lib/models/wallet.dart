import 'dart:typed_data';

class Wallet {
  late String walletName;
  late String publicKey;
  late String cipherText;
  late Uint8List secretKey;
  late Uint8List nonce;

  Wallet({
    required this.walletName,
    required this.publicKey,
    required this.cipherText,
    required this.secretKey,
    required this.nonce,
  });

  Map<String, dynamic> toMap() {
    return {
      'walletName': walletName,
      'publicKey': publicKey,
      'cipherText': cipherText,
      'secretKey': secretKey,
      'nonce': nonce
    };
  }

  Wallet.fromMap(Map<String, dynamic> map) {
    walletName = map['walletName'];
    publicKey = map['publicKey'];
    cipherText = map['cipherText'];
    secretKey = map['secretKey'];
    nonce = map['nonce'];
  }
}
