class ResponseTagihanInquiry {
  Data data;
  String message;
  bool success;

  ResponseTagihanInquiry({this.data, this.message, this.success});

  ResponseTagihanInquiry.fromJson(Map<String, dynamic> json) {
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
  int nominal;
  int totalLateDay;
  String transactionId;

  Data({this.nominal, this.totalLateDay, this.transactionId});

  Data.fromJson(Map<String, dynamic> json) {
    nominal = json['nominal'];
    totalLateDay = json['total_late_day'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nominal'] = this.nominal;
    data['total_late_day'] = this.totalLateDay;
    data['transaction_id'] = this.transactionId;
    return data;
  }
}
