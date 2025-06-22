import 'package:intl/intl.dart';

/// 금액을 #,### 형태로 포맷
String formatPrice(int price) {
  final formatter = NumberFormat('#,###');
  return formatter.format(price);
}

/// 소수점 포함한 금액 포맷 (ex. 12,345.67)
String formatPriceWithDecimal(double price) {
  final formatter = NumberFormat('#,##0.00');
  return formatter.format(price);
}
