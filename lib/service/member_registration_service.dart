import 'dart:convert';

import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/memberregistration/registration_member_model.dart';
import 'package:alhikmah_app/model/memberregistration/registration_submit_member_model.dart';
import 'package:alhikmah_app/model/memberregistration/success_registration_member_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/init_registration_member_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/second_registration_business_owner_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/second_registration_employee_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/third_registration_business_owner_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/third_registration_employee_payload_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';

class MemberRegistrationService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<RegistrationMemberModel> getRegistration() async {
    Response response = await _dio.get(Endpoint.registrationMember,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return RegistrationMemberModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<SuccessRegistrationMemberModel> initRegistration(
      InitRegistrationMemberPayloadModel payload) async {
    Response response = await _dio.post(Endpoint.initRegistrationMember,
        data: payload.toJson(),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return SuccessRegistrationMemberModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<SuccessRegistrationMemberModel> secondRegistrationEmployee(
      SecondRegistrationEmployeePayloadModel payload) async {
    Response response = await _dio.post(Endpoint.secondRegistrationMember,
        data: payload.toJson(),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return SuccessRegistrationMemberModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<SuccessRegistrationMemberModel> secondRegistrationBusinessOwner(
      SecondRegistrationBusinessOwnerPayloadModel payload) async {
    Response response = await _dio.post(Endpoint.secondRegistrationMember,
        data: payload.toJson(),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return SuccessRegistrationMemberModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<SuccessRegistrationMemberModel> thirdRegistrationEmployee(
      ThirdRegistrationEmployeePayloadModel payload) async {
    Response response = await _dio.post(Endpoint.thirdRegistrationMember,
        data: payload.toJson(),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return SuccessRegistrationMemberModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<SuccessRegistrationMemberModel> thirdRegistrationBusinessOwner(
      ThirdRegistrationBusinessOwnerPayloadModel payload) async {
    Response response = await _dio.post(Endpoint.thirdRegistrationMember,
        data: payload.toJson(),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return SuccessRegistrationMemberModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<SuccessRegistrationMemberModel> accountRegistrationMember(
      Map<String, dynamic> payload) async {
    var data = {
      'account_bank_code': payload['account_bank_code'],
      'account_holder_name': payload['account_holder_name'],
      'account_number': payload['account_number'],
    };
    Response response = await _dio.post(Endpoint.accountRegistrationMember,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return SuccessRegistrationMemberModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<RegistrationSubmitMemberModel> submitRegistrationMember() async {
    Response response = await _dio.post(Endpoint.submitRegistrationMember,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return RegistrationSubmitMemberModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<dynamic> resubmitRegistrationMember() async {
    Response response = await _dio.post(Endpoint.resubmitRegistrationMember,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return (response.data);
    } else {
      return null;
    }
  }
}
