import 'dart:convert';

import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/user/balance_model.dart';
import 'package:alhikmah_app/model/user/me_model.dart';
import 'package:alhikmah_app/model/user/verify_pin_model.dart';
import 'package:alhikmah_app/model/user/virtual_account_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';

class UserService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<MeModel> me() async {
    Response response = await _dio.get(Endpoint.me,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return MeModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<VerifyPinModel> verifyPin(Map<String, dynamic> payload) async {
    var data = {
      'pin': payload['pin'],
    };

    Response response = await _dio.post(Endpoint.verifyPin,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return VerifyPinModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<BalanceModel> balance() async {
    Response response = await _dio.get(Endpoint.balance,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return BalanceModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<VirtualAccountModel> vaZipay() async {
    Response response = await _dio.get(Endpoint.vaZipay,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return VirtualAccountModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
