import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_business_place_status_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_disburse_bank_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_job_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_last_education_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_residence_status_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/master_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  MasterState get initialState => MasterInitial();

  @override
  Stream<MasterState> mapEventToState(
    MasterEvent event,
  ) async* {
    if (event is ResidenceStatusEvent) {
      yield* _residenceStatus(event);
    } else if (event is JobEvent) {
      yield* _job(event);
    } else if (event is LastEducationEvent) {
      yield* _lastEducation(event);
    } else if (event is BusinessPlaceStatusEvent) {
      yield* _businessPlaceStatus(event);
    } else if (event is DisburseBankEvent) {
      yield* _disburseBank(event);
    }
  }

  Stream<MasterState> _residenceStatus(ResidenceStatusEvent event) async* {
    yield MasterInitial();

    ItemResidenceStatusModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MasterService().residenceStatus();
      } else {
        response = await MasterService().residenceStatus();
      }

      yield GetResidenceStatusSuccessState(data: response);
    } catch (err) {
      yield GetResidenceStatusFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MasterState> _lastEducation(LastEducationEvent event) async* {
    yield MasterInitial();

    ItemLastEducationModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MasterService().lastEducation();
      } else {
        response = await MasterService().lastEducation();
      }

      yield GetLastEducationSuccessState(data: response);
    } catch (err) {
      yield GetLastEducationFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MasterState> _job(JobEvent event) async* {
    yield MasterInitial();

    ItemJobModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MasterService().job();
      } else {
        response = await MasterService().job();
      }

      yield GetJobSuccessState(data: response);
    } catch (err) {
      yield GetJobFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<MasterState> _businessPlaceStatus(BusinessPlaceStatusEvent event) async* {
    yield MasterInitial();

    ItemBusinessPlaceStatusModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MasterService().businessPlaceStatus();
      } else {
        response = await MasterService().businessPlaceStatus();
      }

      yield GetBusinessPlaceStatusSuccessState(data: response);
    } catch (err) {
      yield GetBusinessPlaceStatusFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MasterState> _disburseBank(DisburseBankEvent event) async* {
    yield MasterInitial();

    ItemDisburseBankModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MasterService().disburseBank();
      } else {
        response = await MasterService().disburseBank();
      }

      yield GetDisburseBankSuccessState(data: response);
    } catch (err) {
      yield GetDisburseBankFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  checkRefreshToken() async {
    try {
      Map<String, dynamic> payload = {
        'refresh_token': _prefs.getString(SharePrefs.REFRESH_TOKEN),
      };
      RefreshTokenModel responseRefresh;
      responseRefresh = await AuthService().refreshToken(payload);
      _prefs.setString(
          SharePrefs.ACCESS_TOKEN, responseRefresh.data.accessToken);
      _prefs.setString(
          SharePrefs.REFRESH_TOKEN, responseRefresh.data.refreshToken);
      _prefs.setInt(SharePrefs.EXPIRES_TOKEN, responseRefresh.data.expiresAt);
    } catch (err) {
      AppUtil.showToast(err?.response?.statusCode.toString());
    }
  }
}
