// To parse this JSON data, do
//
//     final uploadPublicModel = uploadPublicModelFromJson(jsonString);

import 'dart:convert';

UploadPublicModel uploadPublicModelFromJson(String str) =>
    UploadPublicModel.fromJson(json.decode(str));

String uploadPublicModelToJson(UploadPublicModel data) =>
    json.encode(data.toJson());

class UploadPublicModel {
  UploadPublicModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory UploadPublicModel.fromJson(Map<String, dynamic> json) =>
      UploadPublicModel(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data.toJson(),
        'message': message,
        'success': success,
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
        objectName: json['object_name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() =>
      {
        'object_name': objectName,
        'url': url,
      };
}
