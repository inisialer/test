// To parse this JSON data, do
//
//     final itemLastEducationModel = itemLastEducationModelFromJson(jsonString);

import 'dart:convert';

ItemLastEducationModel itemLastEducationModelFromJson(String str) =>
    ItemLastEducationModel.fromJson(json.decode(str));

String itemLastEducationModelToJson(ItemLastEducationModel data) =>
    json.encode(data.toJson());

class ItemLastEducationModel {
  ItemLastEducationModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ItemLastEducationModel.fromJson(Map<String, dynamic> json) =>
      ItemLastEducationModel(
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
