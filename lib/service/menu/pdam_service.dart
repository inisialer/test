import 'dart:convert';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/ppob/pdam/inquiry_pdam_model.dart';
import 'package:alhikmah_app/model/ppob/pdam/pdam_areas_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdamService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<PdamAreasModel> pdamAreas() async {
    Response response = await _dio.get(Endpoint.pdamAreas,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return PdamAreasModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<InquiryPdamModel> inquiryPdam(Map<String, dynamic> payload) async {
    var data = {
      'area_id': payload['area_id'],
      'customer_id': payload['customer_id'],
    };
    Response response = await _dio.post(Endpoint.inquiryPdam,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return InquiryPdamModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
