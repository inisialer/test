import 'dart:convert';

import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/ppob/pln/inquiry_pln_pascabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pln/inquiry_pln_prabayar_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class PlnService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<InquiryPlnPascabayarModel> inquiryPlnPascabayar(
      Map<String, dynamic> payload) async {
    var data = {
      'no_meter': payload['no_meter'],
    };
    Response response = await _dio.post(Endpoint.inquiryPlnPascabayar,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return InquiryPlnPascabayarModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<InquiryPlnPrabayarModel> inquiryPlnPrabayar(
      Map<String, dynamic> payload) async {
    var data = {
      'no_meter': payload['no_meter'],
      'nominal': payload['nominal'],
    };
    Response response = await _dio.post(Endpoint.inquiryPlnPrabayar,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return InquiryPlnPrabayarModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
