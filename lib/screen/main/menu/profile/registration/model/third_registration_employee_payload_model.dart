// To parse this JSON data, do
//
//     final thirdRegistrationEmployeePayloadModel = thirdRegistrationEmployeePayloadModelFromJson(jsonString);

import 'dart:convert';

ThirdRegistrationEmployeePayloadModel
    thirdRegistrationEmployeePayloadModelFromJson(String str) =>
        ThirdRegistrationEmployeePayloadModel.fromJson(json.decode(str));

String thirdRegistrationEmployeePayloadModelToJson(
        ThirdRegistrationEmployeePayloadModel data) =>
    json.encode(data.toJson());

class ThirdRegistrationEmployeePayloadModel {
  ThirdRegistrationEmployeePayloadModel({
    this.selfiePhoto,
    this.ktpPhoto,
    this.signaturePhoto,
    this.ktpValidityPeriod,
    this.nationality,
  });

  String selfiePhoto;
  String ktpPhoto;
  String signaturePhoto;
  String ktpValidityPeriod;
  String nationality;

  factory ThirdRegistrationEmployeePayloadModel.fromJson(
          Map<String, dynamic> json) =>
      ThirdRegistrationEmployeePayloadModel(
        selfiePhoto: json["selfie_photo"],
        ktpPhoto: json["ktp_photo"],
        signaturePhoto: json["signature_photo"],
        ktpValidityPeriod: json["ktp_validity_period"],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "selfie_photo": selfiePhoto,
        "ktp_photo": ktpPhoto,
        "signature_photo": signaturePhoto,
        "ktp_validity_period": ktpValidityPeriod,
        "nationality": nationality,
      };
}
