// To parse this JSON data, do
//
//     final uploadPrivateModel = uploadPrivateModelFromJson(jsonString);

import 'dart:convert';

UploadPrivateModel uploadPrivateModelFromJson(String str) =>
    UploadPrivateModel.fromJson(json.decode(str));

String uploadPrivateModelToJson(UploadPrivateModel data) =>
    json.encode(data.toJson());

class UploadPrivateModel {
  UploadPrivateModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory UploadPrivateModel.fromJson(Map<String, dynamic> json) =>
      UploadPrivateModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "success": success,
      };
}

class Data {
  Data({
    this.objectName,
    this.url,
  });

  String objectName;
  String url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        objectName: json["object_name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object_name": objectName,
        "url": url,
      };
}
