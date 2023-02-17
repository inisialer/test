// To parse this JSON data, do
//
//     final itemPaketModel = itemPaketModelFromJson(jsonString);

import 'dart:convert';

ItemPaketPrabayarModel itemPaketModelFromJson(String str) =>
    ItemPaketPrabayarModel.fromJson(json.decode(str));

String itemPaketModelToJson(ItemPaketPrabayarModel data) =>
    json.encode(data.toJson());

class ItemPaketPrabayarModel {
  ItemPaketPrabayarModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<ItemPaketDatum> data;

  factory ItemPaketPrabayarModel.fromJson(Map<String, dynamic> json) =>
      ItemPaketPrabayarModel(
        success: json["success"],
        message: json["message"],
        data: List<ItemPaketDatum>.from(
            json["data"].map((x) => ItemPaketDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ItemPaketDatum {
  ItemPaketDatum({
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

  factory ItemPaketDatum.fromJson(Map<String, dynamic> json) => ItemPaketDatum(
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
