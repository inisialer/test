import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/ppob/pdam/bloc.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/ppob/pdam/inquiry_pdam_model.dart';
import 'package:alhikmah_app/model/ppob/pdam/pdam_areas_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/menu/pdam_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdamBloc extends Bloc<PdamEvent, PdamState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  PdamState get initialState => PdamInitial();

  @override
  Stream<PdamState> mapEventToState(
    PdamEvent event,
  ) async* {
    if (event is PdamAreasEvent) {
      yield* _pdamAreas(event);
    } else if (event is InquiryPdamEvent) {
      yield* _inquiryPdam(event);
    }
  }

  Stream<PdamState> _pdamAreas(PdamAreasEvent event) async* {
    yield PdamInitial();

    PdamAreasModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PdamService().pdamAreas();
      } else {
        response = await PdamService().pdamAreas();
      }

      yield GetPdamAreasSuccessState(data: response);
    } catch (err) {
      yield GetPdamAreasFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PdamState> _inquiryPdam(InquiryPdamEvent event) async* {
    yield PdamInitial();

    InquiryPdamModel response;

    Map<String, dynamic> payload = {
      'area_id': event.areaId.trim(),
      'customer_id': event.customerId.trim(),
    };

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PdamService().inquiryPdam(payload);
      } else {
        response = await PdamService().inquiryPdam(payload);
      }

      yield GetInquiryPdamSuccessState(data: response);
    } catch (err) {
      yield GetInquiryPdamFailedState(
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
