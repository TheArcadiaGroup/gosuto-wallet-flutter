class Settings {
  String? password;
  int? useBiometricAuth;

  Settings({
    this.password,
    this.useBiometricAuth,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'useBiometricAuth': useBiometricAuth,
    };
  }

  Settings.fromMap(Map<String, dynamic> map) {
    password = map['password'];
    useBiometricAuth = map['useBiometricAuth'];
  }
}
