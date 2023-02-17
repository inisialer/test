// To parse this JSON data, do
//
//     final historyDetailPulsaModel = historyDetailPulsaModelFromJson(jsonString);

import 'dart:convert';

HistoryDetailPulsaModel historyDetailPulsaModelFromJson(String str) =>
    HistoryDetailPulsaModel.fromJson(json.decode(str));

String historyDetailPulsaModelToJson(HistoryDetailPulsaModel data) =>
    json.encode(data.toJson());

class HistoryDetailPulsaModel {
  HistoryDetailPulsaModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory HistoryDetailPulsaModel.fromJson(Map<String, dynamic> json) =>
      HistoryDetailPulsaModel(
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
    this.createdAt,
    this.desc,
    this.payment,
    this.phoneNumber,
    this.price,
    this.product,
    this.productCode,
    this.productId,
    this.provider,
    this.ref1,
    this.ref2,
    this.sn,
    this.status,
    this.statusCode,
    this.userId,
  });

  String createdAt;
  String desc;
  Payment payment;
  String phoneNumber;
  int price;
  Product product;
  String productCode;
  String productId;
  String provider;
  String ref1;
  String ref2;
  String sn;
  String status;
  String statusCode;
  String userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdAt: json["created_at"] == null ? null : json["created_at"],
        desc: json["desc"] == null ? null : json["desc"],
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        price: json["price"] == null ? null : json["price"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        productCode: json["product_code"] == null ? null : json["product_code"],
        productId: json["product_id"] == null ? null : json["product_id"],
        provider: json["provider"] == null ? null : json["provider"],
        ref1: json["ref1"] == null ? null : json["ref1"],
        ref2: json["ref2"] == null ? null : json["ref2"],
        sn: json["sn"] == null ? null : json["sn"],
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        userId: json["user_id"] == null ? null : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt == null ? null : createdAt,
        "desc": desc == null ? null : desc,
        "payment": payment == null ? null : payment.toJson(),
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "price": price == null ? null : price,
        "product": product == null ? null : product.toJson(),
        "product_code": productCode == null ? null : productCode,
        "product_id": productId == null ? null : productId,
        "provider": provider == null ? null : provider,
        "ref1": ref1 == null ? null : ref1,
        "ref2": ref2 == null ? null : ref2,
        "sn": sn == null ? null : sn,
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "user_id": userId == null ? null : userId,
      };
}

class Payment {
  Payment({
    this.amount,
    this.createdAt,
    this.isPaid,
    this.isRefunded,
    this.paidAt,
    this.paymentMethod,
    this.refundAmount,
    this.refundAt,
    this.refundCancellationDate,
    this.refundCode,
    this.vaAccountNumber,
    this.vaBankCode,
    this.vaExpiredAt,
    this.vaReferalCode,
  });

  int amount;
  String createdAt;
  bool isPaid;
  bool isRefunded;
  String paidAt;
  String paymentMethod;
  int refundAmount;
  String refundAt;
  String refundCancellationDate;
  String refundCode;
  String vaAccountNumber;
  String vaBankCode;
  String vaExpiredAt;
  String vaReferalCode;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        amount: json["amount"] == null ? null : json["amount"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        isPaid: json["is_paid"] == null ? null : json["is_paid"],
        isRefunded: json["is_refunded"] == null ? null : json["is_refunded"],
        paidAt: json["paid_at"] == null ? null : json["paid_at"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        refundAmount:
            json["refund_amount"] == null ? null : json["refund_amount"],
        refundAt: json["refund_at"] == null ? null : json["refund_at"],
        refundCancellationDate: json["refund_cancellation_date"] == null
            ? null
            : json["refund_cancellation_date"],
        refundCode: json["refund_code"] == null ? null : json["refund_code"],
        vaAccountNumber: json["va_account_number"] == null
            ? null
            : json["va_account_number"],
        vaBankCode: json["va_bank_code"] == null ? null : json["va_bank_code"],
        vaExpiredAt:
            json["va_expired_at"] == null ? null : json["va_expired_at"],
        vaReferalCode:
            json["va_referal_code"] == null ? null : json["va_referal_code"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "created_at": createdAt == null ? null : createdAt,
        "is_paid": isPaid == null ? null : isPaid,
        "is_refunded": isRefunded == null ? null : isRefunded,
        "paid_at": paidAt == null ? null : paidAt,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "refund_amount": refundAmount == null ? null : refundAmount,
        "refund_at": refundAt == null ? null : refundAt,
        "refund_cancellation_date":
            refundCancellationDate == null ? null : refundCancellationDate,
        "refund_code": refundCode == null ? null : refundCode,
        "va_account_number": vaAccountNumber == null ? null : vaAccountNumber,
        "va_bank_code": vaBankCode == null ? null : vaBankCode,
        "va_expired_at": vaExpiredAt == null ? null : vaExpiredAt,
        "va_referal_code": vaReferalCode == null ? null : vaReferalCode,
      };
}

class Product {
  Product({
    this.price,
    this.productCode,
    this.productDesc,
    this.productName,
    this.provider,
  });

  int price;
  String productCode;
  String productDesc;
  String productName;
  Provider provider;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        price: json["price"] == null ? null : json["price"],
        productCode: json["product_code"] == null ? null : json["product_code"],
        productDesc: json["product_desc"] == null ? null : json["product_desc"],
        productName: json["product_name"] == null ? null : json["product_name"],
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "price": price == null ? null : price,
        "product_code": productCode == null ? null : productCode,
        "product_desc": productDesc == null ? null : productDesc,
        "product_name": productName == null ? null : productName,
        "provider": provider == null ? null : provider.toJson(),
      };
}

class Provider {
  Provider({
    this.picture,
    this.provider,
  });

  String picture;
  String provider;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        picture: json["picture"] == null ? null : json["picture"],
        provider: json["provider"] == null ? null : json["provider"],
      );

  Map<String, dynamic> toJson() => {
        "picture": picture == null ? null : picture,
        "provider": provider == null ? null : provider,
      };
}
