import 'package:hdkey/hdkey.dart';

class CasperHDKey {
  final _bip44Index = 506;
  late HDKey _hdKey;

  CasperHDKey(HDKey hdKey) {
    _hdKey = hdKey;
  }

  String _bip44Path(int index) {
    return [
      "m",
      "44'", // bip 44
      "$_bip44Index'", // coin index
      "0'", // wallet
      "0", // external
      "$index" // child account index
    ].join('/');
  }

  /// Derive the child key basing the path
  /// @param path
  HDKey derive(String path) {
    HDKey childKey = _hdKey.derive(path);
    return childKey;
  }

  /// Derive child key basing the bip44 protocol
  /// @param index the index of child key
  HDKey deriveIndex(int index) {
    return derive(_bip44Path(index));
  }
}
