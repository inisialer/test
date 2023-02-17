import 'dart:convert';

import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/ppob/pulsa/inquiry_pulsa_pascabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/item_paket_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/item_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/phone_provider_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/recent_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/recent_pulsa_prabayar_phone_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/request_pulsa_prabayar_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class PulsaService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<PhoneProviderModel> phoneProvider(String code) async {
    Response response = await _dio.get(Endpoint.phoneProvider(code),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return PhoneProviderModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ItemPulsaPrabayarModel> itemPulsaPrabayar(String provider) async {
    Response response = await _dio.get(Endpoint.masterPulsaPrabayar,
        queryParameters: {
          'product_type': 'pulsa',
          'provider': provider,
        },
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ItemPulsaPrabayarModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ItemPaketPrabayarModel> itemPaketPrabayar(String provider) async {
    Response response = await _dio.get(Endpoint.masterPulsaPrabayar,
        queryParameters: {
          'product_type': 'paket',
          'provider': provider,
        },
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ItemPaketPrabayarModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<RecentPulsaPrabayarModel> recentPulsaPrabayar() async {
    Response response = await _dio.get(Endpoint.recentPulsaPrabayar,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return RecentPulsaPrabayarModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<RecentPulsaPrabayarPhoneModel> recentPulsaPrabayarPhone() async {
    Response response = await _dio.get(Endpoint.recentPulsaPrabayarPhone,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return RecentPulsaPrabayarPhoneModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<RequestPulsaPrabayarModel> requestPulsaPrabayar(
      Map<String, dynamic> payload) async {
    var data = {
      'payment_method': payload['payment_method'],
      'phone_number': payload['phone_number'],
      'product_code': payload['product_code'],
      'va_bank_code': payload['va_bank_code'],
    };
    Response response = await _dio.post(Endpoint.requestPulsaPrabayar,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return RequestPulsaPrabayarModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<InquiryPulsaPascabayarModel> inquiryPulsaPascabayar(
      Map<String, dynamic> payload) async {
    var data = {
      'phone_number': payload['phone_number'],
    };
    Response response = await _dio.post(Endpoint.inquiryPulsaPascabayar,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return InquiryPulsaPascabayarModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
