import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:convert/convert.dart';

class GosutoEncode {
  AesCbc algorithm = AesCbc.with256bits(macAlgorithm: Hmac.sha256());

  Future<String> encodeWallet(
      String walletKey, SecretKey secretKey, List<int> nonce) async {
    final secretBox = await algorithm.encrypt(
      Uint8List.fromList(walletKey.codeUnits),
      secretKey: secretKey,
      nonce: nonce,
    );

    return hex.encode(secretBox.cipherText);
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

  Future<String> hashPassword(String password) async {
    final sink = Sha512().newHashSink();
    sink.add(Uint8List.fromList(password.codeUnits));
    sink.close();
    final hash = await sink.hash();

    return hex.encode(Uint8List.fromList(hash.bytes));
  }
}
