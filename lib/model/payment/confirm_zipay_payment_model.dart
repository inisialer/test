// To parse this JSON data, do
//
//     final confirmZipayPaymentModel = confirmZipayPaymentModelFromJson(jsonString);

import 'dart:convert';

ConfirmZipayPaymentModel confirmZipayPaymentModelFromJson(String str) =>
    ConfirmZipayPaymentModel.fromJson(json.decode(str));

String confirmZipayPaymentModelToJson(ConfirmZipayPaymentModel data) =>
    json.encode(data.toJson());

class ConfirmZipayPaymentModel {
  ConfirmZipayPaymentModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory ConfirmZipayPaymentModel.fromJson(Map<String, dynamic> json) =>
      ConfirmZipayPaymentModel(
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
  });

  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
