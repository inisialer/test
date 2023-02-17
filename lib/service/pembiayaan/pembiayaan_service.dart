import 'dart:convert';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/model/pembiayaan/capital_loan_model.dart';
import 'package:alhikmah_app/model/pembiayaan/tenor_pembiayaan_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/endpoint.dart';
import '../../data/shared_preferences.dart';

class PembiayaanService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<TenorPembiayaanModel> getTenor() async {
    Response response = await _dio.get(Endpoint.tenorPembiyaan,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return TenorPembiayaanModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<CapitalLoanModel> getCapitalLoan(int nominal, String tenorId) async {
    var map = {"nominal": nominal, "tenor_id": tenorId};
    Response response = await _dio.post(Endpoint.capitalLoan,
        data: jsonEncode(map),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return CapitalLoanModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<bool> getCapitalReq(String calculateId, String tujuanModal) async {
    var map = {"calculated_id": calculateId, "capital_purpose": tujuanModal};
    Response response = await _dio.post(Endpoint.capitalRequest,
        data: jsonEncode(map),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return (response.data['success']);
    } else {
      return null;
    }
  }
}
