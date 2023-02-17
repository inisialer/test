class PaymentModel {
  String no;
  String noTransaction;
  String name;
  int bill;
  int admin;
  int total;
  String typeMenu;

  String pdamCity;
  String pdamNo;
  String pdamName;
  String pdamPeriod;

  String bpjsNo;
  String bpjsName;
  String bpjsPeriod;

  String plnName;
  String plnNo;

  String pascabayarNo;
  String pascabayarName;
  String pascabayarOperator;

  String pulsaNo;
  String pulsaCode;
  String pulsaType;
  String pulsaDesc;

  PaymentModel(
      {this.no,
      this.noTransaction,
      this.name,
      this.bill,
      this.admin,
      this.total,
      this.typeMenu,
      this.pdamCity,
      this.pdamNo,
      this.pdamName,
      this.pdamPeriod,
      this.bpjsNo,
      this.bpjsName,
      this.bpjsPeriod,
      this.plnNo,
      this.plnName,
      this.pascabayarNo,
      this.pascabayarName,
      this.pascabayarOperator,
      this.pulsaNo,
      this.pulsaCode,
      this.pulsaType,
      this.pulsaDesc});
}
