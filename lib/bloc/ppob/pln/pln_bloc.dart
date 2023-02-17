import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/ppob/pln/inquiry_pln_pascabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pln/inquiry_pln_prabayar_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/menu/pln_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class PlnBloc extends Bloc<PlnEvent, PlnState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  PlnState get initialState => PlnInitial();

  @override
  Stream<PlnState> mapEventToState(
    PlnEvent event,
  ) async* {
    if (event is InquiryPlnPascabayarEvent) {
      yield* _inquiryPlnPascabayar(event);
    } else if (event is InquiryPlnPrabayarEvent) {
      yield* _inquiryPlnPrabayar(event);
    }
  }

  Stream<PlnState> _inquiryPlnPascabayar(InquiryPlnPascabayarEvent event) async* {
    yield PlnInitial();

    InquiryPlnPascabayarModel response;

    Map<String, dynamic> payload = {
      'no_meter': event.noMeter.trim(),
    };

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PlnService().inquiryPlnPascabayar(payload);
      } else {
        response = await PlnService().inquiryPlnPascabayar(payload);
      }

      yield GetInquiryPlnPascabayarSuccessState(data: response);
    } catch (err) {
      yield GetInquiryPlnPascabayarFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PlnState> _inquiryPlnPrabayar(InquiryPlnPrabayarEvent event) async* {
    yield PlnInitial();

    InquiryPlnPrabayarModel response;

    Map<String, dynamic> payload = {
      'no_meter': event.noMeter.trim(),
      'nominal': event.nominal
    };

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PlnService().inquiryPlnPrabayar(payload);
      } else {
        response = await PlnService().inquiryPlnPrabayar(payload);
      }

      yield GetInquiryPlnPrabayarSuccessState(data: response);
    } catch (err) {
      yield GetInquiryPlnPrabayarFailedState(
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
