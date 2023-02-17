// To parse this JSON data, do
//
//     final itemJobModel = itemJobModelFromJson(jsonString);

import 'dart:convert';

ItemJobModel itemJobModelFromJson(String str) =>
    ItemJobModel.fromJson(json.decode(str));

String itemJobModelToJson(ItemJobModel data) => json.encode(data.toJson());

class ItemJobModel {
  ItemJobModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ItemJobModel.fromJson(Map<String, dynamic> json) => ItemJobModel(
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
    this.id,
    this.value,
  });

  String id;
  String value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
