import 'payment_controller.dart';

class PackList {
  static List packlist = [];

  getPack(PaymentTypes paymentTypes) {
    if (packlist.isEmpty) {
      return 'null';
    }

    if (paymentTypes == PaymentTypes.premium1month) {
      return packlist[0];
    } else if (paymentTypes == PaymentTypes.premium3month) {
      return packlist[1];
    } else if (paymentTypes == PaymentTypes.premium6month) {
      return packlist[2];
    } else if (paymentTypes == PaymentTypes.pettypass1pack) {
      return packlist[3];
    } else if (paymentTypes == PaymentTypes.pettypass5pack) {
      return packlist[5];
    } else if (paymentTypes == PaymentTypes.pettypass10pack) {
      return packlist[6];
    } else if (paymentTypes == PaymentTypes.rewind1time) {
      return packlist[4];
    } else if (paymentTypes == PaymentTypes.rewind1month) {
      return packlist[7];
    } else if (paymentTypes == PaymentTypes.rewind3month) {
      return packlist[8];
    } else if (paymentTypes == PaymentTypes.rewind6month) {
      return packlist[9];
    } else if (paymentTypes == PaymentTypes.superpetty1month) {
      return packlist[10];
    } else if (paymentTypes == PaymentTypes.superpetty3month) {
      return packlist[11];
    } else if (paymentTypes == PaymentTypes.superpetty6month) {
      return packlist[12];
    } else if (paymentTypes == PaymentTypes.unlock1time) {
      return packlist[13];
    }
  }

  getPaymentAmount(PaymentTypes paymentTypes) {
    var pack = getPack(paymentTypes);
    if (pack != null) {
      double amount = 0.0;
      try {
        amount = double.parse(pack['amount']);
      } catch (e) {}
      ;
      return amount;
    }
  }
}
