import 'package:alhikmah_app/model/auth/change_pin_model.dart';
import 'package:alhikmah_app/model/auth/check_user_model.dart';
import 'package:alhikmah_app/model/auth/forgot_pin_model.dart';
import 'package:alhikmah_app/model/auth/login_model.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/auth/register_model.dart';
import 'package:alhikmah_app/model/auth/resend_otp_model.dart';
import 'package:alhikmah_app/model/auth/verify_otp_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class CheckUserSuccessState extends AuthState {
  final CheckUserModel data;

  CheckUserSuccessState({this.data});
}

class CheckUserFailedState extends AuthState {
  final String message;

  CheckUserFailedState({this.message});
}

class LoginSuccessState extends AuthState {
  final LoginModel data;

  LoginSuccessState({this.data});
}

class LoginFailedState extends AuthState {
  final String message;

  LoginFailedState({this.message});
}

class ResendOtpSuccessState extends AuthState {
  final ResendOtpModel data;

  ResendOtpSuccessState({this.data});
}

class ResendOtpFailedState extends AuthState {
  final String message;

  ResendOtpFailedState({this.message});
}

class VerifyOtpSuccessState extends AuthState {
  final VerifyOtpModel data;

  VerifyOtpSuccessState({this.data});
}

class VerifyOtpFailedState extends AuthState {
  final String message;

  VerifyOtpFailedState({this.message});
}

class RegisterSuccessState extends AuthState {
  final RegisterModel data;

  RegisterSuccessState({this.data});
}

class RegisterFailedState extends AuthState {
  final String message;

  RegisterFailedState({this.message});
}

class RefreshTokenSuccessState extends AuthState {
  final RefreshTokenModel data;

  RefreshTokenSuccessState({this.data});
}

class RefreshTokenFailedState extends AuthState {
  final String message;

  RefreshTokenFailedState({this.message});
}

class ChangePinSuccessState extends AuthState {
  final ChangePinModel data;

 ChangePinSuccessState({this.data});
}

class ChangePinFailedState extends AuthState {
  final String message;

  ChangePinFailedState({this.message});
}


class ForgotPinSuccessState extends AuthState {
  final ForgotPinModel data;

 ForgotPinSuccessState({this.data});
}

class ForgotPinFailedState extends AuthState {
  final String message;

  ForgotPinFailedState({this.message});
}

