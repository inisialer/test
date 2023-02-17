// To parse this JSON data, do
//
//     final itemDisburseBankModel = itemDisburseBankModelFromJson(jsonString);

import 'dart:convert';

ItemDisburseBankModel itemDisburseBankModelFromJson(String str) =>
    ItemDisburseBankModel.fromJson(json.decode(str));

String itemDisburseBankModelToJson(ItemDisburseBankModel data) =>
    json.encode(data.toJson());

class ItemDisburseBankModel {
  ItemDisburseBankModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ItemDisburseBankModel.fromJson(Map<String, dynamic> json) =>
      ItemDisburseBankModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.bankName,
    this.bankCode,
  });

  String bankName;
  String bankCode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bankName: json["bankName"],
        bankCode: json["bankCode"],
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "bankCode": bankCode,
      };
}
