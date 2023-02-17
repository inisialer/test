// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);


import 'dart:convert';

ForgotPinModel checkUserModelFromJson(String str) =>
    ForgotPinModel.fromJson(json.decode(str));

String checkUserModelToJson(ForgotPinModel data) => json.encode(data.toJson());

class ForgotPinModel {
  ForgotPinModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  dynamic data;

  factory ForgotPinModel.fromJson(Map<String, dynamic> json) => ForgotPinModel(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
