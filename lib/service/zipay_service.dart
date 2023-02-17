
import 'dart:convert';

import 'package:alhikmah_app/model/util/convert_base_64_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_check_kyc_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_history_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_update_kyc_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_va_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';
import '../data/endpoint.dart';
import '../data/shared_preferences.dart';

class ZipayService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<ZipayCheckKYCModel> checkStatusKyc() async {
    Response response = await _dio.get(Endpoint.statusKyc,
        options: Options(
          headers: {
            'authorization':
            'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ZipayCheckKYCModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ZipayHistoryModel> historyZipay() async {
    Response response = await _dio.get(Endpoint.transactionHistory,
        options: Options(
          headers: {
            'authorization':
            'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ZipayHistoryModel.fromJson(response.data);
    } else {
      return null;
    }
  }
  Future<ZipayVAModel> getVA() async {
    Response response = await _dio.get(Endpoint.transactionVa,
        options: Options(
          headers: {
            'authorization':
            'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ZipayVAModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ZipayUpdateKYCModel> updateKyc(Map<String, dynamic> payload) async {
    var data = {
      'id_card': payload['id_card'],
      'selfie': payload['selfie'],
    };
    Response response = await _dio.post(
      Endpoint.updateKyc,
      data: jsonEncode(data),
      options: Options(headers: {
        'authorization':
        'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
      },)
    );

    if (response.statusCode == 200) {
      return ZipayUpdateKYCModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}