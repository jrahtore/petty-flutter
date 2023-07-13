import 'package:intl/intl.dart';

mixin UniversalMixins {
  String getAmount(String amount, int month) {
    NumberFormat formatter = new NumberFormat("0.00");
    double d = double.parse(amount.substring(0, amount.indexOf('.') + 3));
    d = d / month;
    return formatter.format(d);
  }
}
