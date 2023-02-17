// To parse this JSON data, do
//
//     final verifyPinModel = verifyPinModelFromJson(jsonString);

import 'dart:convert';

VerifyPinModel verifyPinModelFromJson(String str) =>
    VerifyPinModel.fromJson(json.decode(str));

String verifyPinModelToJson(VerifyPinModel data) => json.encode(data.toJson());

class VerifyPinModel {
  VerifyPinModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory VerifyPinModel.fromJson(Map<String, dynamic> json) => VerifyPinModel(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.isPinMatch,
  });

  bool isPinMatch;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isPinMatch: json['is_pin_match'],
      );

  Map<String, dynamic> toJson() =>
      {
        'is_pin_match': isPinMatch,
      };
}
