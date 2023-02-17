import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/model/tabungan/check_tagihan_saving_model.dart';
import 'package:alhikmah_app/model/tabungan/mutasi_tagihan_model.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/shared_preferences.dart';
import '../../model/tabungan/tabungan_list_model.dart';

class TabunganListService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<TabunganListModel> getList() async {
    try {
      Response response = await _dio.get(Endpoint.tabunganList,
          options: Options(
            headers: {
              'authorization':
                  'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
            },
          ));

      if (response.statusCode == 200) {
        return TabunganListModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<MutationSavingModel> getMutasiTabungan(String id) async {
    try {
      Response response = await _dio.get(Endpoint.tabunganMutasi(id),
          options: Options(
            headers: {
              'authorization':
                  'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
            },
          ));

      if (response.statusCode == 200) {
        return MutationSavingModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CheckTagihanSavingModel> getCheckTagihan(String savingType) async {
    try {
      Response response = await _dio.post(Endpoint.tabunganCheckTagihan,
          data: {'saving_type': savingType},
          options: Options(
            headers: {
              'authorization':
                  'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
            },
          ));

      if (response.statusCode == 200) {
        return CheckTagihanSavingModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> totalTabungan() async {
    try {
      Response response = await _dio.get(Endpoint.totalTabungan,
          options: Options(
            headers: {
              'authorization':
                  'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
            },
          ));

      if (response.statusCode == 200) {
        return (AppUtil()
            .formattedMoneyIDR(response.data['data']['total_balance'])
            .toString());
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
