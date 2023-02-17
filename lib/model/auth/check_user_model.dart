// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromJson(jsonString);

import 'dart:convert';

CheckUserModel checkUserModelFromJson(String str) =>
    CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

class CheckUserModel {
  CheckUserModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory CheckUserModel.fromJson(Map<String, dynamic> json) => CheckUserModel(
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
    this.isRegistered,
    this.isPhoneNumberVerified,
  });

  bool isRegistered;
  bool isPhoneNumberVerified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isRegistered: json["is_registered"],
        isPhoneNumberVerified: json["is_phone_number_verified"],
      );

  Map<String, dynamic> toJson() => {
        "is_registered": isRegistered,
        "is_phone_number_verified": isPhoneNumberVerified,
      };
}
