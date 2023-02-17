class CheckTagihanSavingModel {
  bool success;
  String message;
  Data data;

  CheckTagihanSavingModel({this.success, this.message, this.data});

  CheckTagihanSavingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String transactionId;
  int bill;

  Data({this.transactionId, this.bill});

  Data.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    bill = json['bill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['bill'] = this.bill;
    return data;
  }
}
