// To parse this JSON data, do
//
//     final thirdRegistrationBusinessOwnerPayloadModel = thirdRegistrationBusinessOwnerPayloadModelFromJson(jsonString);

import 'dart:convert';

ThirdRegistrationBusinessOwnerPayloadModel
    thirdRegistrationBusinessOwnerPayloadModelFromJson(String str) =>
        ThirdRegistrationBusinessOwnerPayloadModel.fromJson(json.decode(str));

String thirdRegistrationBusinessOwnerPayloadModelToJson(
        ThirdRegistrationBusinessOwnerPayloadModel data) =>
    json.encode(data.toJson());

class ThirdRegistrationBusinessOwnerPayloadModel {
  ThirdRegistrationBusinessOwnerPayloadModel({
    this.selfiePhoto,
    this.ktpPhoto,
    this.npwpPhoto,
    this.businessPlacePhoto,
    this.businessActivityPhoto,
    this.businessLicensePhoto,
    this.placeOwnershipProofPhoto,
  });

  String selfiePhoto;
  String ktpPhoto;
  String npwpPhoto;
  String businessPlacePhoto;
  String businessActivityPhoto;
  String businessLicensePhoto;
  String placeOwnershipProofPhoto;

  factory ThirdRegistrationBusinessOwnerPayloadModel.fromJson(
          Map<String, dynamic> json) =>
      ThirdRegistrationBusinessOwnerPayloadModel(
        selfiePhoto: json["selfie_photo"],
        ktpPhoto: json["ktp_photo"],
        npwpPhoto: json["npwp_photo"],
        businessPlacePhoto: json["business_place_photo"],
        businessActivityPhoto: json["business_activity_photo"],
        businessLicensePhoto: json["business_license_photo"],
        placeOwnershipProofPhoto: json["place_ownership_proof_photo"],
      );

  Map<String, dynamic> toJson() => {
        "selfie_photo": selfiePhoto,
        "ktp_photo": ktpPhoto,
        "npwp_photo": npwpPhoto,
        "business_place_photo": businessPlacePhoto,
        "business_activity_photo": businessActivityPhoto,
        "business_license_photo": businessLicensePhoto,
        "place_ownership_proof_photo": placeOwnershipProofPhoto,
      };
}
