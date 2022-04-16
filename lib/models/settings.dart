class Settings {
  late String seedPhrase;
  late String password;
  late int useBiometricAuth;

  Settings({
    required this.seedPhrase,
    required this.password,
    required this.useBiometricAuth,
  });

  Map<String, dynamic> toMap() {
    return {
      'seedPhrase': seedPhrase,
      'password': password,
      'useBiometricAuth': useBiometricAuth,
    };
  }

  Settings.fromMap(Map<String, dynamic> map) {
    seedPhrase = map['seedPhrase'];
    password = map['password'];
    useBiometricAuth = map['useBiometricAuth'];
  }
}
