// To parse this JSON data, do
//
//     final requestPulsaModel = requestPulsaModelFromJson(jsonString);

import 'dart:convert';

RequestPulsaPrabayarModel requestPulsaModelFromJson(String str) =>
    RequestPulsaPrabayarModel.fromJson(json.decode(str));

String requestPulsaModelToJson(RequestPulsaPrabayarModel data) =>
    json.encode(data.toJson());

class RequestPulsaPrabayarModel {
  RequestPulsaPrabayarModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory RequestPulsaPrabayarModel.fromJson(Map<String, dynamic> json) =>
      RequestPulsaPrabayarModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.transactionId,
  });

  String transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
      };
}
