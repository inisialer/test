// To parse this JSON data, do
//
//     final billerPaymentMethodModel = billerPaymentMethodModelFromJson(jsonString);

import 'dart:convert';

BillerPaymentMethodModel billerPaymentMethodModelFromJson(String str) => BillerPaymentMethodModel.fromJson(json.decode(str));

String billerPaymentMethodModelToJson(BillerPaymentMethodModel data) => json.encode(data.toJson());

class BillerPaymentMethodModel {
  BillerPaymentMethodModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory BillerPaymentMethodModel.fromJson(Map<String, dynamic> json) => BillerPaymentMethodModel(
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
