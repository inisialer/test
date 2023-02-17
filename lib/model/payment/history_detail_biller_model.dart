// To parse this JSON data, do
//
//     final historyDetailBillerModel = historyDetailBillerModelFromJson(jsonString);

import 'dart:convert';

HistoryDetailBillerModel historyDetailBillerModelFromJson(String str) =>
    HistoryDetailBillerModel.fromJson(json.decode(str));

String historyDetailBillerModelToJson(HistoryDetailBillerModel data) =>
    json.encode(data.toJson());

class HistoryDetailBillerModel {
  HistoryDetailBillerModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory HistoryDetailBillerModel.fromJson(Map<String, dynamic> json) =>
      HistoryDetailBillerModel(
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
    this.customerName,
    this.desc,
    this.idPel1,
    this.idPel2,
    this.idPel3,
    this.internalAdminFee,
    this.nominal,
    this.payment,
    this.periode,
    this.productCode,
    this.rajabillerAdminFee,
    this.ref1,
    this.ref2,
    this.ref3,
    this.status,
    this.statusCode,
    this.transactionId,
    this.transactionType,
    this.urlStruk,
  });

  String createdAt;
  String customerName;
  String desc;
  String idPel1;
  String idPel2;
  String idPel3;
  int internalAdminFee;
  int nominal;
  Payment payment;
  String periode;
  String productCode;
  int rajabillerAdminFee;
  String ref1;
  String ref2;
  String ref3;
  String status;
  String statusCode;
  String transactionId;
  String transactionType;
  String urlStruk;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdAt: json["created_at"] == null ? null : json["created_at"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        desc: json["desc"] == null ? null : json["desc"],
        idPel1: json["id_pel1"] == null ? null : json["id_pel1"],
        idPel2: json["id_pel2"] == null ? null : json["id_pel2"],
        idPel3: json["id_pel3"] == null ? null : json["id_pel3"],
        internalAdminFee: json["internal_admin_fee"] == null
            ? null
            : json["internal_admin_fee"],
        nominal: json["nominal"] == null ? null : json["nominal"],
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        periode: json["periode"] == null ? null : json["periode"],
        productCode: json["product_code"] == null ? null : json["product_code"],
        rajabillerAdminFee: json["rajabiller_admin_fee"] == null
            ? null
            : json["rajabiller_admin_fee"],
        ref1: json["ref1"] == null ? null : json["ref1"],
        ref2: json["ref2"] == null ? null : json["ref2"],
        ref3: json["ref3"] == null ? null : json["ref3"],
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        transactionType:
            json["transaction_type"] == null ? null : json["transaction_type"],
        urlStruk: json["url_struk"] == null ? null : json["url_struk"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt == null ? null : createdAt,
        "customer_name": customerName == null ? null : customerName,
        "desc": desc == null ? null : desc,
        "id_pel1": idPel1 == null ? null : idPel1,
        "id_pel2": idPel2 == null ? null : idPel2,
        "id_pel3": idPel3 == null ? null : idPel3,
        "internal_admin_fee":
            internalAdminFee == null ? null : internalAdminFee,
        "nominal": nominal == null ? null : nominal,
        "payment": payment == null ? null : payment.toJson(),
        "periode": periode == null ? null : periode,
        "product_code": productCode == null ? null : productCode,
        "rajabiller_admin_fee":
            rajabillerAdminFee == null ? null : rajabillerAdminFee,
        "ref1": ref1 == null ? null : ref1,
        "ref2": ref2 == null ? null : ref2,
        "ref3": ref3 == null ? null : ref3,
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "transaction_id": transactionId == null ? null : transactionId,
        "transaction_type": transactionType == null ? null : transactionType,
        "url_struk": urlStruk == null ? null : urlStruk,
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
