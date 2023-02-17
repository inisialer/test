import 'dart:convert';

import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/model/auth/change_pin_model.dart';
import 'package:alhikmah_app/model/auth/check_user_model.dart';
import 'package:alhikmah_app/model/auth/forgot_pin_model.dart';
import 'package:alhikmah_app/model/auth/login_model.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/auth/register_model.dart';
import 'package:alhikmah_app/model/auth/resend_otp_model.dart';
import 'package:alhikmah_app/model/auth/verify_otp_model.dart';
import 'package:dio/dio.dart';

import '../app.dart';

class AuthService {
  Dio _dio = App().dio;

  Future<CheckUserModel> checkUser(Map<String, dynamic> payload) async {
    var data = {
      'phone_number': payload['phone_number'],
    };
    Response response = await _dio.post(
      Endpoint.checkUser,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return CheckUserModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ChangePinModel> changePin(Map<String, dynamic> payload) async {
    var data = {
      'phone_number': payload['phone_number'],
      'pin': payload['pin'],
      'otp': payload['otp'],
    };

    Response response = await _dio.post(
      Endpoint.verifyChangePassword,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return ChangePinModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ForgotPinModel> forgotPin(Map<String, dynamic> payload) async {
    var data = {
      'phone_number': payload['phone_number'],
    };

    Response response = await _dio.post(
      Endpoint.changePassword,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return ForgotPinModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<LoginModel> login(Map<String, dynamic> payload) async {
    var data = {
      'phone_number': payload['phone_number'],
      'pin': payload['pin'],
    };
    Response response = await _dio.post(
      Endpoint.login,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return LoginModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ResendOtpModel> resendOtp(Map<String, dynamic> payload) async {
    var data = {
      'phone_number': payload['phone_number'],
    };
    Response response = await _dio.post(
      Endpoint.resendOtp,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return ResendOtpModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<VerifyOtpModel> verifyOtp(Map<String, dynamic> payload) async {
    var data = {
      'phone_number': payload['phone_number'],
      'verification_code': payload['verification_code'],
    };
    Response response = await _dio.post(
      Endpoint.verifyOtp,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return VerifyOtpModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<RegisterModel> register(Map<String, dynamic> payload) async {
    var data = {
      'email': payload['email'],
      'first_name': payload['first_name'],
      'last_name': payload['last_name'],
      'phone_number': payload['phone_number'],
      'pin': payload['pin'],
      'profile_photo': payload['profile_photo'],
    };
    Response response = await _dio.post(
      Endpoint.register,
      data: data,
    );

    if (response.statusCode == 200) {
      return RegisterModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<RefreshTokenModel> refreshToken(Map<String, dynamic> payload) async {
    var data = {
      'refresh_token': payload['refresh_token'],
    };
    Response response = await _dio.post(
      Endpoint.refreshToken,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return RefreshTokenModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
