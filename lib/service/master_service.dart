import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_business_place_status_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_disburse_bank_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_job_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_last_education_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_residence_status_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<ItemResidenceStatusModel> residenceStatus() async {
    Response response = await _dio.get(Endpoint.residenceStatus,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ItemResidenceStatusModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ItemLastEducationModel> lastEducation() async {
    Response response = await _dio.get(Endpoint.lastEducation,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ItemLastEducationModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ItemJobModel> job() async {
    Response response = await _dio.get(Endpoint.job,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ItemJobModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ItemBusinessPlaceStatusModel> businessPlaceStatus() async {
    Response response = await _dio.get(Endpoint.businessPlaceStatus,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ItemBusinessPlaceStatusModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ItemDisburseBankModel> disburseBank() async {
    Response response = await _dio.get(Endpoint.disburseBank,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ItemDisburseBankModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
