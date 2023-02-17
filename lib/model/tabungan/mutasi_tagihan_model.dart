class MutationSavingModel {
  bool success;
  String message;
  List<Data> data;

  MutationSavingModel({this.success, this.message, this.data});

  MutationSavingModel.fromJson(Map<String, dynamic> json) {
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
  String savingId;
  String mutationType;
  int nominal;
  int balance;
  String timestamp;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.savingId,
      this.mutationType,
      this.nominal,
      this.balance,
      this.timestamp,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    savingId = json['saving_id'];
    mutationType = json['mutation_type'];
    nominal = json['nominal'];
    balance = json['balance'];
    timestamp = json['timestamp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['saving_id'] = this.savingId;
    data['mutation_type'] = this.mutationType;
    data['nominal'] = this.nominal;
    data['balance'] = this.balance;
    data['timestamp'] = this.timestamp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
