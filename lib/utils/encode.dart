import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:secp256k1/secp256k1.dart';

class GosutoEncode {
  AesCbc algorithm = AesCbc.with256bits(macAlgorithm: Hmac.sha256());

  void encodeWallet(PrivateKey privateKey, String password, SecretKey secretKey,
      List<int> nonce) async {
    String walletKey = privateKey.toHex() + password;

    await algorithm.encrypt(
      Uint8List.fromList(walletKey.codeUnits),
      secretKey: secretKey,
      nonce: nonce,
    );
  }

  Future<List<int>> decodeWallet(String walletKey, String password,
      SecretKey secretKey, List<int> nonce) async {
    final secretBox = await algorithm.encrypt(
      Uint8List.fromList(walletKey.codeUnits),
      secretKey: secretKey,
      nonce: nonce,
    );

    final decryptData = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );

    return decryptData;
  }
}
