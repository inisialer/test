// To parse this JSON data, do
//
//     final resendOtpModel = resendOtpModelFromJson(jsonString);

import 'dart:convert';

ResendOtpModel resendOtpModelFromJson(String str) =>
    ResendOtpModel.fromJson(json.decode(str));

String resendOtpModelToJson(ResendOtpModel data) => json.encode(data.toJson());

class ResendOtpModel {
  ResendOtpModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) => ResendOtpModel(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
