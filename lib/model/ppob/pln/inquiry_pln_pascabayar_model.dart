// To parse this JSON data, do
//
//     final inquiryPlnPascabayarModel = inquiryPlnPascabayarModelFromJson(jsonString);

import 'dart:convert';

InquiryPlnPascabayarModel inquiryPlnPascabayarModelFromJson(String str) =>
    InquiryPlnPascabayarModel.fromJson(json.decode(str));

String inquiryPlnPascabayarModelToJson(InquiryPlnPascabayarModel data) =>
    json.encode(data.toJson());

class InquiryPlnPascabayarModel {
  InquiryPlnPascabayarModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory InquiryPlnPascabayarModel.fromJson(Map<String, dynamic> json) =>
      InquiryPlnPascabayarModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.transactionId,
    this.customerName,
    this.nominal,
    this.adminFee,
    this.totalNominal,
  });

  String transactionId;
  String customerName;
  int nominal;
  int adminFee;
  int totalNominal;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json["transaction_id"],
        customerName: json["customer_name"],
        nominal: json["nominal"],
        adminFee: json["admin_fee"],
        totalNominal: json["total_nominal"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "customer_name": customerName,
        "nominal": nominal,
        "admin_fee": adminFee,
        "total_nominal": totalNominal,
      };
}
