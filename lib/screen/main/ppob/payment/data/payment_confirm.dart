import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:flutter/material.dart';

class PaymentConfirmModel {
  String noOrName;
  String type;
  String noTransaction;
  String date;
  int bill;
  int admin;
  int total;
  String typeMenu;
  String paymentMethod;
  String menuDataNoOrName;
  String menuDataType;
  DataBank bank;

  String pdamCity;
  String pdamNo;
  String pdamName;
  String pdamPeriod;

  String bpjsNo;
  String bpjsName;
  String bpjsPeriod;

  String plnNo;

  String pascabayarNo;
  String pascabayarName;
  String pascabayarOperator;

  String pulsaNo;
  String pulsaCode;
  String pulsaType;
  String pulsaDesc;

  PaymentConfirmModel(
      {@required this.noOrName,
      @required this.type,
      @required this.noTransaction,
      @required this.date,
      @required this.bill,
      @required this.admin,
      @required this.total,
      @required this.typeMenu,
      @required this.paymentMethod,
      @required this.menuDataNoOrName,
      @required this.menuDataType,
      this.pdamCity,
      this.pdamNo,
      this.pdamName,
      this.pdamPeriod,
      this.bpjsNo,
      this.bpjsName,
      this.bpjsPeriod,
      this.plnNo,
      this.pascabayarNo,
      this.pascabayarName,
      this.pascabayarOperator,
      this.pulsaNo,
      this.pulsaCode,
      this.pulsaType,
      this.pulsaDesc,
      this.bank});
}
