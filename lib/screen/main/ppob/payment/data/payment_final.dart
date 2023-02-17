import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:flutter/foundation.dart';

class PaymentFinalModel {
  String noTransaction;
  String type;
  DataBank bank;
  String fromMenu;
  String va;

  PaymentFinalModel(
      {@required this.noTransaction,
      @required this.type,
      this.bank,
      @required this.fromMenu,
      @required this.va});
}
