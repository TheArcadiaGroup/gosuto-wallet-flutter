import 'package:intl/intl.dart';

class NumberUtils {
  static String format(double n, [int decimalDigits = 3]) {
    var f = NumberFormat('#,##0.0###', 'en_US');
    if (n % 1 == 0) {
      f.maximumFractionDigits = 0;
    }

    if (decimalDigits > 3) {
      f = NumberFormat.compactCurrency(
          symbol: '', decimalDigits: decimalDigits);
    }
    var formated = f.format(n);
    return formated;
  }

  static String formatCurrency(double n) {
    var f = NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 4);

    return f.format(n);
  }
}
