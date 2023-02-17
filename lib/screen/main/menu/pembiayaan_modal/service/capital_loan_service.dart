import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/data/detail_tagihan_model.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/data/lihat_tagihan_model.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/data/response_tagihan_inquiry.dart';
import 'package:dio/dio.dart';
import 'package:alhikmah_app/app.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/detail_tagihan_head_model.dart';

class CapitalLoanService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<LihatTagihanModel> getCapitalLocanService() async {
    Response response = await _dio.get(Endpoint.tagihanList,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return LihatTagihanModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<DetailTagihanModel> lihatTagihanDetail(String id) async {
    Response response = await _dio.get("capital/$id/installment",
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return DetailTagihanModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<DetailTagihanHeadModel> lihatTagihanHeadDetail(String id) async {
    Response response = await _dio.get("capital/installment/$id",
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return DetailTagihanHeadModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ResponseTagihanInquiry> responseTagihanInquiry(String id) async {
    Map<String, dynamic> data = {"capital_loan_id": "$id"};
    Response response = await _dio.post("capital-loan/inquiry",
        data: data,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ResponseTagihanInquiry.fromJson(response.data);
    } else {
      return null;
    }
  }
}
