// To parse this JSON data, do
//
//     final inquiryPlnPrabayarModel = inquiryPlnPrabayarModelFromJson(jsonString);

import 'dart:convert';

InquiryPlnPrabayarModel inquiryPlnPrabayarModelFromJson(String str) =>
    InquiryPlnPrabayarModel.fromJson(json.decode(str));

String inquiryPlnPrabayarModelToJson(InquiryPlnPrabayarModel data) =>
    json.encode(data.toJson());

class InquiryPlnPrabayarModel {
  InquiryPlnPrabayarModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory InquiryPlnPrabayarModel.fromJson(Map<String, dynamic> json) =>
      InquiryPlnPrabayarModel(
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
