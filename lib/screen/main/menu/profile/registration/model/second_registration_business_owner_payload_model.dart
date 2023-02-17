// To parse this JSON data, do
//
//     final secondRegistrationBusinessOwnerPayloadModel = secondRegistrationBusinessOwnerPayloadModelFromJson(jsonString);

import 'dart:convert';

SecondRegistrationBusinessOwnerPayloadModel
    secondRegistrationBusinessOwnerPayloadModelFromJson(String str) =>
        SecondRegistrationBusinessOwnerPayloadModel.fromJson(json.decode(str));

String secondRegistrationBusinessOwnerPayloadModelToJson(
        SecondRegistrationBusinessOwnerPayloadModel data) =>
    json.encode(data.toJson());

class SecondRegistrationBusinessOwnerPayloadModel {
  SecondRegistrationBusinessOwnerPayloadModel({
    this.statusBusinessLegal,
    this.statusBusinessPlace,
    this.averageMonthlyProfit,
    this.businessAddress,
    this.businessPhone,
  });

  String statusBusinessLegal;
  String statusBusinessPlace;
  String averageMonthlyProfit;
  String businessAddress;
  String businessPhone;

  factory SecondRegistrationBusinessOwnerPayloadModel.fromJson(
          Map<String, dynamic> json) =>
      SecondRegistrationBusinessOwnerPayloadModel(
        statusBusinessLegal: json["status_business_legal"],
        statusBusinessPlace: json["status_business_place"],
        averageMonthlyProfit: json["average_monthly_profit"],
        businessAddress: json["business_address"],
        businessPhone: json["business_phone"],
      );

  Map<String, dynamic> toJson() => {
        "status_business_legal": statusBusinessLegal,
        "status_business_place": statusBusinessPlace,
        "average_monthly_profit": averageMonthlyProfit,
        "business_address": businessAddress,
        "business_phone": businessPhone,
      };
}
