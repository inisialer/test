import 'dart:convert';
import 'dart:io';

import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/util/convert_base_64_model.dart';
import 'package:alhikmah_app/model/util/upload_private_model.dart';
import 'package:alhikmah_app/model/util/upload_public_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';

class UtilService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<UploadPrivateModel> uploadPrivate(File file, String category) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
      'category': category,
    });

    Response response = await _dio.post(Endpoint.uploadPrivate,
        data: data,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));
    if (response.statusCode == 200) {
      return UploadPrivateModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<UploadPublicModel> uploadPublic(File file, String category) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
      'category': category,
    });

    String username = 'alhikmah-apidev';
    String password =
        '3GkMnnt4THFreNEPVfjW45v2BNAPTktm9RnvaP8tyErCx5XfC6HX7vbtvtKWzCMRdu4dmWFsVd5V5MwSkhR7fqPWmD9cM7JQ48Vx';
    String basicAuth = base64Encode(utf8.encode('$username:$password'));

    Response response = await _dio.post(Endpoint.uploadPublic,
        data: data,
        options: Options(
          headers: {'authorization': 'Basic ' + basicAuth},
        ));
    if (response.statusCode == 200) {
      return UploadPublicModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ConvertBase64Model> uploadConvert(File file) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    Response response = await _dio.post(Endpoint.convertBase,
        data: data,
        options: Options(
          headers: {
            'authorization':
            'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));
    if (response.statusCode == 200) {
      return ConvertBase64Model.fromJson(response.data);
    } else {
      return null;
    }
  }
}
