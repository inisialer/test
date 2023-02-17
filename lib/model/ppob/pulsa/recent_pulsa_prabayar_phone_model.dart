// To parse this JSON data, do
//
//     final recentPulsaPhoneModel = recentPulsaPhoneModelFromJson(jsonString);

import 'dart:convert';

RecentPulsaPrabayarPhoneModel recentPulsaPhoneModelFromJson(String str) =>
    RecentPulsaPrabayarPhoneModel.fromJson(json.decode(str));

String recentPulsaPhoneModelToJson(RecentPulsaPrabayarPhoneModel data) =>
    json.encode(data.toJson());

class RecentPulsaPrabayarPhoneModel {
  RecentPulsaPrabayarPhoneModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<ItemRecentPulsaPrabayarPhoneDatum> data;

  factory RecentPulsaPrabayarPhoneModel.fromJson(Map<String, dynamic> json) =>
      RecentPulsaPrabayarPhoneModel(
        success: json["success"],
        message: json["message"],
        data: List<ItemRecentPulsaPrabayarPhoneDatum>.from(json["data"]
            .map((x) => ItemRecentPulsaPrabayarPhoneDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ItemRecentPulsaPrabayarPhoneDatum {
  ItemRecentPulsaPrabayarPhoneDatum({
    this.phoneNumber,
  });

  String phoneNumber;

  factory ItemRecentPulsaPrabayarPhoneDatum.fromJson(
          Map<String, dynamic> json) =>
      ItemRecentPulsaPrabayarPhoneDatum(
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
      };
}
