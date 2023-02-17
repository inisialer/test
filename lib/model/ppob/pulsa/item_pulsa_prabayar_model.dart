// To parse this JSON data, do
//
//     final itemPulsaModel = itemPulsaModelFromJson(jsonString);

import 'dart:convert';

ItemPulsaPrabayarModel itemPulsaModelFromJson(String str) =>
    ItemPulsaPrabayarModel.fromJson(json.decode(str));

String itemPulsaModelToJson(ItemPulsaPrabayarModel data) =>
    json.encode(data.toJson());

class ItemPulsaPrabayarModel {
  ItemPulsaPrabayarModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<ItemPulsaPrabayarDatum> data;

  factory ItemPulsaPrabayarModel.fromJson(Map<String, dynamic> json) =>
      ItemPulsaPrabayarModel(
        success: json["success"],
        message: json["message"],
        data: List<ItemPulsaPrabayarDatum>.from(
            json["data"].map((x) => ItemPulsaPrabayarDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ItemPulsaPrabayarDatum {
  ItemPulsaPrabayarDatum({
    this.provider,
    this.productCode,
    this.productName,
    this.productDesc,
    this.price,
  });

  Provider provider;
  String productCode;
  String productName;
  String productDesc;
  int price;

  factory ItemPulsaPrabayarDatum.fromJson(Map<String, dynamic> json) =>
      ItemPulsaPrabayarDatum(
        provider: Provider.fromJson(json["provider"]),
        productCode: json["product_code"],
        productName: json["product_name"],
        productDesc: json["product_desc"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "provider": provider.toJson(),
        "product_code": productCode,
        "product_name": productName,
        "product_desc": productDesc,
        "price": price,
      };
}

class Provider {
  Provider({
    this.provider,
    this.picture,
  });

  String provider;
  String picture;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        provider: json["provider"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "picture": picture,
      };
}
