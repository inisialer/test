import 'package:alhikmah_app/model/payment/biller_payment_method_model.dart';
import 'package:alhikmah_app/model/payment/confirm_va_payment_model.dart';
import 'package:alhikmah_app/model/payment/confirm_zipay_payment_model.dart';
import 'package:alhikmah_app/model/payment/history_detail_biller_model.dart';
import 'package:alhikmah_app/model/payment/history_detail_pulsa_model.dart';
import 'package:alhikmah_app/model/payment/history_transaction_model.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class GetVaBankSuccessState extends PaymentState {
  final ItemVaBankModel data;

  GetVaBankSuccessState({this.data});
}

class GetVaBankFailedState extends PaymentState {
  final String message;

  GetVaBankFailedState({this.message});
}

class ConfirmVaPaymentSuccessState extends PaymentState {
  final ConfirmVaPaymentModel data;

  ConfirmVaPaymentSuccessState({this.data});
}

class ConfirmVaPaymentFailedState extends PaymentState {
  final String message;

  ConfirmVaPaymentFailedState({this.message});
}

class ConfirmZipayPaymentSuccessState extends PaymentState {
  final ConfirmZipayPaymentModel data;

  ConfirmZipayPaymentSuccessState({this.data});
}

class ConfirmZipayPaymentFailedState extends PaymentState {
  final String message;

  ConfirmZipayPaymentFailedState({this.message});
}

class BillerPaymentMethodSuccessState extends PaymentState {
  final BillerPaymentMethodModel data;

  BillerPaymentMethodSuccessState({this.data});
}

class BillerPaymentMethodFailedState extends PaymentState {
  final String message;

  BillerPaymentMethodFailedState({this.message});
}

class HistoryTransactionSuccessState extends PaymentState {
  final HistoryTransactionModel data;
  final String sortBy;
  final String startDate;
  final String endDate;

  HistoryTransactionSuccessState(
      {this.data, this.startDate, this.endDate, this.sortBy});
}

class HistoryTransactionFailedState extends PaymentState {
  final String message;

  HistoryTransactionFailedState({this.message});
}

class DetailHistoryBillerSuccessState extends PaymentState {
  final HistoryDetailBillerModel data;

  DetailHistoryBillerSuccessState({this.data});
}

class DetailHistoryBillerFailedState extends PaymentState {
  final String message;

  DetailHistoryBillerFailedState({this.message});
}

class DetailHistoryPulsaSuccessState extends PaymentState {
  final HistoryDetailPulsaModel data;

  DetailHistoryPulsaSuccessState({this.data});
}

class DetailHistoryPulsaFailedState extends PaymentState {
  final String message;

  DetailHistoryPulsaFailedState({this.message});
}
