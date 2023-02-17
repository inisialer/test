import 'dart:convert';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/ppob/bpjs/inquiry_bpjs_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BpjsService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<InquiryBpjsModel> inquiryBpjs(Map<String, dynamic> payload) async {
    var data = {
      'family_va_number': payload['family_va_number'],
      'pay_until': payload['pay_until'],
    };
    Response response = await _dio.post(Endpoint.inquiryBpjs,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return InquiryBpjsModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
