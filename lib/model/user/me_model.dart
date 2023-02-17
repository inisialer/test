// To parse this JSON data, do
//
//     final meModel = meModelFromJson(jsonString);

import 'dart:convert';

MeModel meModelFromJson(String str) => MeModel.fromJson(json.decode(str));

String meModelToJson(MeModel data) => json.encode(data.toJson());

class MeModel {
  MeModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory MeModel.fromJson(Map<String, dynamic> json) => MeModel(
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
    this.email,
    this.firstName,
    this.id,
    this.lastName,
    this.phoneNumber,
    this.profilePhoto,
    this.status,
  });

  String email;
  String firstName;
  String id;
  String lastName;
  String phoneNumber;
  String profilePhoto;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        firstName: json["first_name"],
        id: json["id"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        profilePhoto: json["profile_photo"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "id": id,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "profile_photo": profilePhoto,
        "status": status,
      };
}
