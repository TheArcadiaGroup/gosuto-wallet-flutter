class Strings {
  static String displayHash(String accountHash) {
    if (accountHash.length < 18) {
      return accountHash;
    }
    return accountHash.substring(0, 11) +
      '...' +
      accountHash.substring(accountHash.length - 4, accountHash.length);
  }
}
