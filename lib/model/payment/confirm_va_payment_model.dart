// To parse this JSON data, do
//
//     final confirmVaPaymentModel = confirmVaPaymentModelFromJson(jsonString);

import 'dart:convert';

ConfirmVaPaymentModel confirmVaPaymentModelFromJson(String str) =>
    ConfirmVaPaymentModel.fromJson(json.decode(str));

String confirmVaPaymentModelToJson(ConfirmVaPaymentModel data) =>
    json.encode(data.toJson());

class ConfirmVaPaymentModel {
  ConfirmVaPaymentModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory ConfirmVaPaymentModel.fromJson(Map<String, dynamic> json) =>
      ConfirmVaPaymentModel(
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
    this.status,
    this.accountNumber,
    this.expiredAt,
  });

  String status;
  String accountNumber;
  DateTime expiredAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        accountNumber: json["account_number"],
        expiredAt: DateTime.parse(json["expired_at"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "account_number": accountNumber,
        "expired_at": expiredAt.toIso8601String(),
      };
}
