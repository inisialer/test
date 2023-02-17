import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckUserEvent extends AuthEvent {
  final String phone;

  CheckUserEvent({
    @required this.phone,
  });

  @override
  String toString() => 'CheckUserEvent';
}

class ForgotPinEvent extends AuthEvent {
  final String phone;

  ForgotPinEvent({
    @required this.phone,
  });

  @override
  String toString() => 'ForgotPinEvent';
}

class ChangePinEvent extends AuthEvent {
  final String phone;
  final String otp;
  final String pin;

  ChangePinEvent({
    @required this.phone,
    @required this.otp,
    @required this.pin,
  });

  @override
  String toString() => 'ChangePinEvent';
}


class LoginEvent extends AuthEvent {
  final String phone;
  final String pin;

  LoginEvent({
    @required this.phone,
    @required this.pin,
  });

  @override
  String toString() => 'LoginEvent';
}

class ResendOtpEvent extends AuthEvent {
  final String phone;

  ResendOtpEvent({@required this.phone});

  @override
  String toString() => 'ResendOtpEvent';
}

class VerifyOtpEvent extends AuthEvent {
  final String phone;
  final String code;

  VerifyOtpEvent({@required this.phone, @required this.code});

  @override
  String toString() => 'VerifyOtpEvent';
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String pin;
  final String profilePhoto;

  RegisterEvent({
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.phone,
    @required this.pin,
    @required this.profilePhoto,
  });

  @override
  String toString() => 'RegisterEvent';
}

class RefreshTokenEvent extends AuthEvent {
  final String refreshToken;

  RefreshTokenEvent({
    @required this.refreshToken,
  });

  @override
  String toString() => 'RefreshTokenEvent';
}
