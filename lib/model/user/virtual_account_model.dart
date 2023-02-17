// To parse this JSON data, do
//
//     final virtualAccountModel = virtualAccountModelFromJson(jsonString);

import 'dart:convert';

VirtualAccountModel virtualAccountModelFromJson(String str) =>
    VirtualAccountModel.fromJson(json.decode(str));

String virtualAccountModelToJson(VirtualAccountModel data) =>
    json.encode(data.toJson());

class VirtualAccountModel {
  VirtualAccountModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory VirtualAccountModel.fromJson(Map<String, dynamic> json) =>
      VirtualAccountModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.bankName,
    this.bankLogo,
    this.vaAccountNumber,
  });

  String bankName;
  String bankLogo;
  String vaAccountNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bankLogo: json["bank_logo"],
        bankName: json["bank_name"],
        vaAccountNumber: json["va_account_number"],
      );

  Map<String, dynamic> toJson() => {
        "bank_logo": bankLogo,
        "bank_name": bankName,
        "va_account_number": vaAccountNumber,
      };
}
