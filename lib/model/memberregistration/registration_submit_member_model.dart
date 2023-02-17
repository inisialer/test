// To parse this JSON data, do
//
//     final registrationSubmitMemberModel = registrationSubmitMemberModelFromJson(jsonString);

import 'dart:convert';

RegistrationSubmitMemberModel registrationSubmitMemberModelFromJson(
        String str) =>
    RegistrationSubmitMemberModel.fromJson(json.decode(str));

String registrationSubmitMemberModelToJson(
        RegistrationSubmitMemberModel data) =>
    json.encode(data.toJson());

class RegistrationSubmitMemberModel {
  RegistrationSubmitMemberModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory RegistrationSubmitMemberModel.fromJson(Map<String, dynamic> json) =>
      RegistrationSubmitMemberModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
        success: json["success"] == null ? null : json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
        "success": success == null ? null : success,
      };
}

class Data {
  Data({
    this.registrationStatus,
    this.rejectReason,
  });

  String registrationStatus;
  String rejectReason;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        registrationStatus: json["registration_status"] == null
            ? null
            : json["registration_status"],
        rejectReason:
            json["reject_reason"] == null ? null : json["reject_reason"],
      );

  Map<String, dynamic> toJson() => {
        "registration_status":
            registrationStatus == null ? null : registrationStatus,
        "reject_reason": rejectReason == null ? null : rejectReason,
      };
}
