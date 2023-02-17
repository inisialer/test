// To parse this JSON data, do
//
//     final inquiryPulsaPascabayarModel = inquiryPulsaPascabayarModelFromJson(jsonString);

import 'dart:convert';

InquiryPulsaPascabayarModel inquiryPulsaPascabayarModelFromJson(String str) =>
    InquiryPulsaPascabayarModel.fromJson(json.decode(str));

String inquiryPulsaPascabayarModelToJson(InquiryPulsaPascabayarModel data) =>
    json.encode(data.toJson());

class InquiryPulsaPascabayarModel {
  InquiryPulsaPascabayarModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory InquiryPulsaPascabayarModel.fromJson(Map<String, dynamic> json) =>
      InquiryPulsaPascabayarModel(
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
    this.provider,
    this.totalNominal,
    this.transactionId,
  });

  int adminFee;
  String customerName;
  int nominal;
  String provider;
  int totalNominal;
  String transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        adminFee: json["admin_fee"],
        customerName: json["customer_name"],
        nominal: json["nominal"],
        provider: json["provider"],
        totalNominal: json["total_nominal"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "admin_fee": adminFee,
        "customer_name": customerName,
        "nominal": nominal,
        "provider": provider,
        "total_nominal": totalNominal,
        "transaction_id": transactionId,
      };
}
