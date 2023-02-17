// To parse this JSON data, do
//
//     final successRegistrationMemberModel = successRegistrationMemberModelFromJson(jsonString);

import 'dart:convert';

SuccessRegistrationMemberModel successRegistrationMemberModelFromJson(
        String str) =>
    SuccessRegistrationMemberModel.fromJson(json.decode(str));

String successRegistrationMemberModelToJson(
        SuccessRegistrationMemberModel data) =>
    json.encode(data.toJson());

class SuccessRegistrationMemberModel {
  SuccessRegistrationMemberModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory SuccessRegistrationMemberModel.fromJson(Map<String, dynamic> json) =>
      SuccessRegistrationMemberModel(
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
