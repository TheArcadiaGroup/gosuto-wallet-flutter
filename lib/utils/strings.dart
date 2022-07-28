class Strings {
  static String displayHash(String accountHash) {
    if (accountHash.length < 18) {
      return accountHash;
    }
    return '${accountHash.substring(0, 6)}...${accountHash.substring(accountHash.length - 6, accountHash.length)}';
  }
}
