class CapitalLoanModel {
  Data data;
  String message;
  bool success;

  CapitalLoanModel({this.data, this.message, this.success});

  CapitalLoanModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String id;
  int interest;
  int monthlyInstallment;
  int nominalAccepted;
  int serviceFee;

  Data(
      {this.id,
      this.interest,
      this.monthlyInstallment,
      this.nominalAccepted,
      this.serviceFee});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    interest = json['interest'];
    monthlyInstallment = json['monthly_installment'];
    nominalAccepted = json['nominal_accepted'];
    serviceFee = json['service_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['interest'] = this.interest;
    data['monthly_installment'] = this.monthlyInstallment;
    data['nominal_accepted'] = this.nominalAccepted;
    data['service_fee'] = this.serviceFee;
    return data;
  }
}
