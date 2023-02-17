// To parse this JSON data, do
//
//     final recentPulsaModel = recentPulsaModelFromJson(jsonString);

import 'dart:convert';

RecentPulsaPrabayarModel recentPulsaModelFromJson(String str) =>
    RecentPulsaPrabayarModel.fromJson(json.decode(str));

String recentPulsaModelToJson(RecentPulsaPrabayarModel data) =>
    json.encode(data.toJson());

class RecentPulsaPrabayarModel {
  RecentPulsaPrabayarModel({
    this.data,
    this.message,
    this.success,
  });

  List<ItemRecentPulsaPrabayarDatum> data;
  String message;
  bool success;

  factory RecentPulsaPrabayarModel.fromJson(Map<String, dynamic> json) =>
      RecentPulsaPrabayarModel(
        data: List<ItemRecentPulsaPrabayarDatum>.from(
            json["data"].map((x) => ItemRecentPulsaPrabayarDatum.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class ItemRecentPulsaPrabayarDatum {
  ItemRecentPulsaPrabayarDatum({
    this.currentPrice,
    this.phoneNumber,
    this.productCode,
    this.productDesc,
    this.productName,
    this.productType,
    this.provider,
    this.providerPic,
    this.purchasedPrice,
  });

  int currentPrice;
  String phoneNumber;
  String productCode;
  String productDesc;
  String productName;
  String productType;
  String provider;
  String providerPic;
  int purchasedPrice;

  factory ItemRecentPulsaPrabayarDatum.fromJson(Map<String, dynamic> json) =>
      ItemRecentPulsaPrabayarDatum(
        currentPrice: json["current_price"],
        phoneNumber: json["phone_number"],
        productCode: json["product_code"],
        productDesc: json["product_desc"],
        productName: json["product_name"],
        productType: json["product_type"],
        provider: json["provider"],
        providerPic: json["provider_pic"],
        purchasedPrice: json["purchased_price"],
      );

  Map<String, dynamic> toJson() => {
        "current_price": currentPrice,
        "phone_number": phoneNumber,
        "product_code": productCode,
        "product_desc": productDesc,
        "product_name": productName,
        "product_type": productType,
        "provider": provider,
        "provider_pic": providerPic,
        "purchased_price": purchasedPrice,
      };
}
