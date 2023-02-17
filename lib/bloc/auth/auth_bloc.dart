import 'dart:async';

import 'package:alhikmah_app/model/auth/change_pin_model.dart';
import 'package:alhikmah_app/model/auth/check_user_model.dart';
import 'package:alhikmah_app/model/auth/forgot_pin_model.dart';
import 'package:alhikmah_app/model/auth/login_model.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/auth/register_model.dart';
import 'package:alhikmah_app/model/auth/resend_otp_model.dart';
import 'package:alhikmah_app/model/auth/verify_otp_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckUserEvent) {
      yield* _checkUser(event);
    } else if (event is LoginEvent) {
      yield* _login(event);
    } else if (event is ResendOtpEvent) {
      yield* _resendOtp(event);
    } else if (event is VerifyOtpEvent) {
      yield* _verifyOtp(event);
    } else if (event is RegisterEvent) {
      yield* _register(event);
    } else if (event is RefreshTokenEvent) {
      yield* _refreshToken(event);
    } else if (event is ChangePinEvent) {
      yield* _changePin(event);
    } else if (event is ForgotPinEvent) {
      yield* _forgotPin(event);
    }
  }

  Stream<AuthState> _checkUser(CheckUserEvent event) async* {
    yield AuthInitial();

    Map<String, dynamic> payload = {
      'phone_number': event.phone.trim(),
    };
    CheckUserModel response;

    try {
      response = await AuthService().checkUser(payload);

      yield CheckUserSuccessState(data: response);
    } catch (err) {
      yield CheckUserFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<AuthState> _login(LoginEvent event) async* {
    yield AuthInitial();

    Map<String, dynamic> payload = {
      'phone_number': event.phone,
      'pin': event.pin.trim(),
    };
    LoginModel response;

    try {
      response = await AuthService().login(payload);

      yield LoginSuccessState(data: response);
    } catch (err) {
      yield LoginFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<AuthState> _changePin(ChangePinEvent event) async* {
    yield AuthInitial();

    Map<String, dynamic> payload = {
      'phone_number': event.phone,
      'pin': event.pin.trim(),
      'otp': event.otp,
    };
    ChangePinModel response;

    try {
      response = await AuthService().changePin(payload);

      yield ChangePinSuccessState(data: response);
    } catch (err) {
      yield ChangePinFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<AuthState> _forgotPin(ForgotPinEvent event) async* {
    yield AuthInitial();

    Map<String, dynamic> payload = {
      'phone_number': event.phone,
    };
    ForgotPinModel response;

    try {
      response = await AuthService().forgotPin(payload);

      yield ForgotPinSuccessState(data: response);
    } catch (err) {
      yield ForgotPinFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<AuthState> _resendOtp(ResendOtpEvent event) async* {
    yield AuthInitial();

    Map<String, dynamic> payload = {
      'phone_number': event.phone.trim(),
    };
    ResendOtpModel response;

    try {
      response = await AuthService().resendOtp(payload);

      yield ResendOtpSuccessState(data: response);
    } catch (err) {
      yield ResendOtpFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<AuthState> _verifyOtp(VerifyOtpEvent event) async* {
    yield AuthInitial();

    Map<String, dynamic> payload = {
      'phone_number': event.phone.trim(),
      'verification_code': event.code.trim(),
    };
    VerifyOtpModel response;

    try {
      response = await AuthService().verifyOtp(payload);

      yield VerifyOtpSuccessState(data: response);
    } catch (err) {
      yield VerifyOtpFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<AuthState> _register(RegisterEvent event) async* {
    yield AuthInitial();

    Map<String, dynamic> payload = {
      'email': event.email.trim(),
      'first_name': event.firstName.trim(),
      'last_name': event.lastName.trim(),
      'phone_number': event.phone.trim(),
      'pin': event.pin.trim(),
      'profile_photo': event.profilePhoto.trim(),
    };
    RegisterModel response;

    try {
      response = await AuthService().register(payload);

      yield RegisterSuccessState(data: response);
    } catch (err) {
      yield RegisterFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<AuthState> _refreshToken(RefreshTokenEvent event) async* {
    yield AuthInitial();

    Map<String, dynamic> payload = {
      'refresh_token': event.refreshToken.trim(),
    };

    RefreshTokenModel response;

    try {
      response = await AuthService().refreshToken(payload);

      yield RefreshTokenSuccessState(data: response);
    } catch (err) {
      yield RefreshTokenFailedState(
          message: err?.response?.statusCode.toString());
    }
  }
}
