// To parse this JSON data, do
//
//     final pdamAreasModel = pdamAreasModelFromJson(jsonString);

import 'dart:convert';

PdamAreasModel pdamAreasModelFromJson(String str) =>
    PdamAreasModel.fromJson(json.decode(str));

String pdamAreasModelToJson(PdamAreasModel data) => json.encode(data.toJson());

class PdamAreasModel {
  PdamAreasModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory PdamAreasModel.fromJson(Map<String, dynamic> json) => PdamAreasModel(
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
    this.area,
    this.groupArea,
  });

  String id;
  String area;
  GroupArea groupArea;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        area: json["area"],
        groupArea: groupAreaValues.map[json["group_area"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "group_area": groupAreaValues.reverse[groupArea],
      };
}

enum GroupArea {
  PDAM_JAKARTA,
  PDAM_JAWA_BARAT,
  PDAM_JAWA_TENGAH,
  PDAM_JAWA_TIMUR,
  PDAM_KALIMANTAN,
  PDAM_SUMATERA,
  PDAM_SULAWESI
}

final groupAreaValues = EnumValues({
  "PDAM JAKARTA": GroupArea.PDAM_JAKARTA,
  "PDAM JAWA BARAT": GroupArea.PDAM_JAWA_BARAT,
  "PDAM JAWA TENGAH": GroupArea.PDAM_JAWA_TENGAH,
  "PDAM JAWA TIMUR": GroupArea.PDAM_JAWA_TIMUR,
  "PDAM KALIMANTAN": GroupArea.PDAM_KALIMANTAN,
  "PDAM SULAWESI": GroupArea.PDAM_SULAWESI,
  "PDAM SUMATERA": GroupArea.PDAM_SUMATERA
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
