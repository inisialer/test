import 'package:alhikmah_app/model/user/balance_model.dart';
import 'package:alhikmah_app/model/user/me_model.dart';
import 'package:alhikmah_app/model/user/verify_pin_model.dart';
import 'package:alhikmah_app/model/user/virtual_account_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class GetMeSuccessState extends UserState {
  final MeModel data;

  GetMeSuccessState({this.data});
}

class GetMeFailedState extends UserState {
  final String message;

  GetMeFailedState({this.message});
}

class VerifyPinSuccessState extends UserState {
  final VerifyPinModel data;

  VerifyPinSuccessState({this.data});
}

class VerifyPinFailedState extends UserState {
  final String message;

  VerifyPinFailedState({this.message});
}

class GetBalanceSuccessState extends UserState {
  final BalanceModel data;
  final String state;

  GetBalanceSuccessState({this.data, this.state});
}

class GetBalanceFailedState extends UserState {
  final String message;

  GetBalanceFailedState({this.message});
}

class GetVaZipaySuccessState extends UserState {
  final VirtualAccountModel data;

  GetVaZipaySuccessState({this.data});
}

class GetVaZipayFailedState extends UserState {
  final String message;

  GetVaZipayFailedState({this.message});
}
