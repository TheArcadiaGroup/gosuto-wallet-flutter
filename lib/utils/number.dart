import 'package:intl/intl.dart';

class NumberUtils {
  static String format(double n) {
    var f = NumberFormat('#,##0.0##', 'en_US');
    if (n % 1 == 0) {
      f.maximumFractionDigits = 0;
    }
    var formated = f.format(n);
    return formated;
  }

  static String formatCurrency(double n, [int fractionDigits = 3]) {
    var f = NumberFormat.compactCurrency(symbol: '\$');

    return f.format(n);
  }
}
