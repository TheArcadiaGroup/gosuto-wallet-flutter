class Strings {
  static String displayHash(String accountHash) {
    if (accountHash.length < 18) {
      return '02' + accountHash;
    }
    return '02' + accountHash.substring(0, 11) +
      '...' +
      accountHash.substring(accountHash.length - 4, accountHash.length);
  }
}
