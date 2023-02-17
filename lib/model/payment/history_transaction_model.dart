// To parse this JSON data, do
//
//     final historyTransactionModel = historyTransactionModelFromJson(jsonString);

import 'dart:convert';

import 'history_detail_biller_model.dart';

HistoryTransactionModel historyTransactionModelFromJson(String str) =>
    HistoryTransactionModel.fromJson(json.decode(str));

String historyTransactionModelToJson(HistoryTransactionModel data) =>
    json.encode(data.toJson());

class HistoryTransactionModel {
  HistoryTransactionModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory HistoryTransactionModel.fromJson(Map<String, dynamic> json) =>
      HistoryTransactionModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
        success: json["success"] == null ? null : json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
        "success": success == null ? null : success,
      };
}

class Data {
  Data({
    this.items,
    this.page,
    this.perPage,
    this.totalData,
    this.totalPage,
  });

  List<ItemHistoryTransaction> items;
  int page;
  int perPage;
  int totalData;
  int totalPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? null
            : List<ItemHistoryTransaction>.from(
                json["items"].map((x) => ItemHistoryTransaction.fromJson(x))),
        page: json["page"] == null ? null : json["page"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        totalData: json["total_data"] == null ? null : json["total_data"],
        totalPage: json["total_page"] == null ? null : json["total_page"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "page": page == null ? null : page,
        "per_page": perPage == null ? null : perPage,
        "total_data": totalData == null ? null : totalData,
        "total_page": totalPage == null ? null : totalPage,
      };
}

class ItemHistoryTransaction {
  ItemHistoryTransaction({
    this.id,
    this.price,
    this.status,
    this.transactionDesc1,
    this.transactionDesc2,
    this.transactionId,
    this.transactionTimestamp,
    this.transactionTitle,
    this.transactionType,
    this.payment,
  });

  String id;
  int price;
  String status;
  String transactionDesc1;
  String transactionDesc2;
  String transactionId;
  String transactionTimestamp;
  String transactionTitle;
  String transactionType;
  Map<String, dynamic> payment;

  factory ItemHistoryTransaction.fromJson(Map<String, dynamic> json) =>
      ItemHistoryTransaction(
        id: json["id"] == null ? null : json["id"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"] == null ? null : json["status"],
        payment: json["payment"] == null ? null : json["payment"],
        transactionDesc1: json["transaction_desc1"] == null
            ? null
            : json["transaction_desc1"],
        transactionDesc2: json["transaction_desc2"] == null
            ? null
            : json["transaction_desc2"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        transactionTimestamp: json["transaction_timestamp"] == null
            ? null
            : json["transaction_timestamp"],
        transactionTitle: json["transaction_title"] == null
            ? null
            : json["transaction_title"],
        transactionType:
            json["transaction_type"] == null ? null : json["transaction_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "price": price == null ? null : price,
        "status": status == null ? null : status,
        "transaction_desc1": transactionDesc1 == null ? null : transactionDesc1,
        "transaction_desc2": transactionDesc2 == null ? null : transactionDesc2,
        "transaction_id": transactionId == null ? null : transactionId,
        "transaction_timestamp":
            transactionTimestamp == null ? null : transactionTimestamp,
        "transaction_title": transactionTitle == null ? null : transactionTitle,
        "transaction_type": transactionType == null ? null : transactionType,
        "payment": payment,
      };
}
