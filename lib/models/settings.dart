import 'dart:typed_data';

class Settings {
  late String password;
  late int useBiometricAuth;
  late Uint8List salt;
  late Uint8List iv;

  Settings({
    required this.password,
    required this.useBiometricAuth,
    required this.salt,
    required this.iv,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'useBiometricAuth': useBiometricAuth,
      'salt': salt,
      'iv': iv,
    };
  }

  Settings.fromMap(Map<String, dynamic> map) {
    password = map['password'];
    useBiometricAuth = map['useBiometricAuth'];
    salt = map['salt'];
    iv = map['iv'];
  }
}
