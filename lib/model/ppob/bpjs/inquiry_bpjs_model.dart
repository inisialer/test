// To parse this JSON data, do
//
//     final inquiryBpjsModel = inquiryBpjsModelFromJson(jsonString);

import 'dart:convert';

InquiryBpjsModel inquiryBpjsModelFromJson(String str) =>
    InquiryBpjsModel.fromJson(json.decode(str));

String inquiryBpjsModelToJson(InquiryBpjsModel data) =>
    json.encode(data.toJson());

class InquiryBpjsModel {
  InquiryBpjsModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory InquiryBpjsModel.fromJson(Map<String, dynamic> json) =>
      InquiryBpjsModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "success": success,
      };
}

class Data {
  Data({
    this.adminFee,
    this.customerName,
    this.nominal,
    this.periode,
    this.totalNominal,
    this.transactionId,
  });

  int adminFee;
  String customerName;
  int nominal;
  String periode;
  int totalNominal;
  String transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        adminFee: json["admin_fee"],
        customerName: json["customer_name"],
        nominal: json["nominal"],
        periode: json["periode"],
        totalNominal: json["total_nominal"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "admin_fee": adminFee,
        "customer_name": customerName,
        "nominal": nominal,
        "periode": periode,
        "total_nominal": totalNominal,
        "transaction_id": transactionId,
      };
}
