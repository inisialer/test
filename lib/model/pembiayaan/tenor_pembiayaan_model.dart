class TenorPembiayaanModel {
  bool success;
  String message;
  List<Data> data;

  TenorPembiayaanModel({this.success, this.message, this.data});

  TenorPembiayaanModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  int value;
  int percentInterest;
  String types;

  Data({this.id, this.name, this.value, this.percentInterest, this.types});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    percentInterest = json['percent_interest'];
    types = json['types'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['percent_interest'] = this.percentInterest;
    data['types'] = this.types;
    return data;
  }
}
