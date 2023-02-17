import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class VaBankEvent extends PaymentEvent {
  VaBankEvent();

  @override
  String toString() => 'VaEvent';
}

class ConfirmVaPaymentEvent extends PaymentEvent {
  final String transactionId;

  ConfirmVaPaymentEvent({
    @required this.transactionId,
  });

  @override
  String toString() => 'ConfirmVaPaymentEvent';
}

class ConfirmZipayPaymentEvent extends PaymentEvent {
  final String transactionId;
  final String zipayPin;

  ConfirmZipayPaymentEvent({
    @required this.transactionId,
    @required this.zipayPin,
  });

  @override
  String toString() => 'ConfirmZipayPaymentEvent';
}

class BillerPaymentMethodEvent extends PaymentEvent {
  final String paymentMethod;
  final String transactionId;
  final String vaBankCode;

  BillerPaymentMethodEvent({
    @required this.paymentMethod,
    @required this.transactionId,
    @required this.vaBankCode,
  });

  @override
  String toString() => 'BillerPaymentMethodEvent';
}

class SavingPaymentMethodEvent extends PaymentEvent {
  final String paymentMethod;
  final String transactionId;
  final String vaBankCode;

  SavingPaymentMethodEvent({
    @required this.paymentMethod,
    @required this.transactionId,
    @required this.vaBankCode,
  });

  @override
  String toString() => 'SavingPaymentMethodEvent';
}

class TagihanPaymentMethodEvent extends PaymentEvent {
  final String paymentMethod;
  final String transactionId;
  final String vaBankCode;

  TagihanPaymentMethodEvent({
    @required this.paymentMethod,
    @required this.transactionId,
    @required this.vaBankCode,
  });

  @override
  String toString() => 'TagihanPaymentMethodEvent';
}

class HistoryTransactionEvent extends PaymentEvent {
  final String startDate;
  final String endDate;
  final String sortBy;
  final int page;
  final int perPage;

  HistoryTransactionEvent(
      {@required this.startDate,
      @required this.endDate,
      @required this.sortBy,
      @required this.page,
      @required this.perPage});

  @override
  String toString() => 'HistoryTransactionEvent';
}

class DetailHistoryBillerEvent extends PaymentEvent {
  final String transactionId;

  DetailHistoryBillerEvent({@required this.transactionId});

  @override
  String toString() => 'DetailHistoryBillerEvent';
}

class DetailHistoryPulsaEvent extends PaymentEvent {
  final String transactionId;

  DetailHistoryPulsaEvent({@required this.transactionId});

  @override
  String toString() => 'DetailHistoryPulsaEvent';
}
