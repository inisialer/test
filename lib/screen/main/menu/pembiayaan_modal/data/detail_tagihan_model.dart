class DetailTagihanModel {
  bool success;
  String message;
  List<Data> data;

  DetailTagihanModel({this.success, this.message, this.data});

  DetailTagihanModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String capitalLoanId;
  String name;
  int bill;
  String dueDate;
  dynamic payment;

  Data(
      {this.id,
      this.capitalLoanId,
      this.name,
      this.bill,
      this.dueDate,
      this.payment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    capitalLoanId = json['capital_loan_id'];
    name = json['name'];
    bill = json['bill'];
    dueDate = json['due_date'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['capital_loan_id'] = this.capitalLoanId;
    data['name'] = this.name;
    data['bill'] = this.bill;
    data['due_date'] = this.dueDate;
    data['payment'] = this.payment;
    return data;
  }
}
