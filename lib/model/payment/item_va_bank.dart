// To parse this JSON data, do
//
//     final itemListBankModel = itemListBankModelFromJson(jsonString);

import 'dart:convert';

ItemVaBankModel itemListBankModelFromJson(String str) =>
    ItemVaBankModel.fromJson(json.decode(str));

String itemListBankModelToJson(ItemVaBankModel data) =>
    json.encode(data.toJson());

class ItemVaBankModel {
  ItemVaBankModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<DataBank> data;

  factory ItemVaBankModel.fromJson(Map<String, dynamic> json) =>
      ItemVaBankModel(
        success: json["success"],
        message: json["message"],
        data:
            List<DataBank>.from(json["data"].map((x) => DataBank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataBank {
  DataBank({
    this.bankCode,
    this.bankName,
    this.bankLogo,
  });

  String bankCode;
  String bankName;
  String bankLogo;

  factory DataBank.fromJson(Map<String, dynamic> json) => DataBank(
        bankCode: json["bank_code"],
        bankName: json["bank_name"],
        bankLogo: json["bank_logo"],
      );

  Map<String, dynamic> toJson() => {
        "bank_code": bankCode,
        "bank_name": bankName,
        "bank_logo": bankLogo,
      };
}
