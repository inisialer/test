
import 'package:alhikmah_app/model/zipay/zipay_check_kyc_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_history_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_update_kyc_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_va_model.dart';
import 'package:equatable/equatable.dart';

abstract class ZipayState extends Equatable {
  const ZipayState();

  @override
  List<Object> get props => [];
}

class ZipayInitial extends ZipayState {}

class TransactionHistorySuccessState extends ZipayState {
  final ZipayHistoryModel data;

  TransactionHistorySuccessState({this.data});
}

class TransactionHistoryFailedState extends ZipayState {
  final String message;

  TransactionHistoryFailedState({this.message});
}

class TransactionVASuccessState extends ZipayState {
  final ZipayVAModel data;

  TransactionVASuccessState({this.data});
}

class TransactionVAFailedState extends ZipayState {
  final String message;

  TransactionVAFailedState({this.message});
}

class StatusKYCSuccessState extends ZipayState {
  final ZipayCheckKYCModel data;

  StatusKYCSuccessState({this.data});
}

class StatusKYCFailedState extends ZipayState {
  final String message;

  StatusKYCFailedState({this.message});
}

class UpdateKYCSuccessState extends ZipayState {
  final ZipayUpdateKYCModel data;

  UpdateKYCSuccessState({this.data});
}

class UpdateKYCFailedState extends ZipayState {
  final String message;

  UpdateKYCFailedState({this.message});
}