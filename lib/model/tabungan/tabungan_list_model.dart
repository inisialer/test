class TabunganListModel {
  bool success;
  String message;
  List<Data> data;

  TabunganListModel({this.success, this.message, this.data});

  TabunganListModel.fromJson(Map<String, dynamic> json) {
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
  String savingType;
  int balance;
  int misc;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.savingType,
      this.balance,
      this.misc,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    savingType = json['saving_type'];
    balance = json['balance'];
    misc = json['misc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['saving_type'] = this.savingType;
    data['balance'] = this.balance;
    data['misc'] = this.misc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
