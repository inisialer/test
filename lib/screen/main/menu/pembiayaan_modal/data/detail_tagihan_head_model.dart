class DetailTagihanHeadModel {
  bool success;
  String message;
  Data data;

  DetailTagihanHeadModel({this.success, this.message, this.data});

  DetailTagihanHeadModel.fromJson(Map<String, dynamic> json) {
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
  int tenor;
  int valuePaid;
  String createdAt;
  int totalValue;
  int valueNeedToPaid;
  int remainingPayment;

  Data(
      {this.tenor,
      this.valuePaid,
      this.createdAt,
      this.totalValue,
      this.valueNeedToPaid,
      this.remainingPayment});

  Data.fromJson(Map<String, dynamic> json) {
    tenor = json['tenor'];
    valuePaid = json['value_paid'];
    createdAt = json['created_at'];
    totalValue = json['total_value'];
    valueNeedToPaid = json['value_need_to_paid'];
    remainingPayment = json['remaining_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenor'] = this.tenor;
    data['value_paid'] = this.valuePaid;
    data['created_at'] = this.createdAt;
    data['total_value'] = this.totalValue;
    data['value_need_to_paid'] = this.valueNeedToPaid;
    data['remaining_payment'] = this.remainingPayment;
    return data;
  }
}
