import 'package:alhikmah_app/model/memberregistration/registration_status_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';
import '../data/endpoint.dart';
import '../data/shared_preferences.dart';

class RegistrationStatusService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<RegistrationStatusModel> getRegistrationStatus() async {
    Response response = await _dio.get(Endpoint.registrationStatus,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return RegistrationStatusModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
