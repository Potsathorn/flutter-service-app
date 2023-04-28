import 'package:intl/intl.dart';

class Helper {
  static String priceFormat(double price) {
    try {
      final formatter = NumberFormat("#,##0", "en_US");
      return formatter.format(price);
    } catch (e) {
      return "0";
    }
  }
}
