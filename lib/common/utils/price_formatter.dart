import 'package:intl/intl.dart';

String formatPrice(int? value) {
  final formatCurrency = NumberFormat.simpleCurrency(name: '€', decimalDigits: 0);
  return formatCurrency.format(value);
}
