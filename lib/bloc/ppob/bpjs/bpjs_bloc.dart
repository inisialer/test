import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/ppob/bpjs/bloc.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/ppob/bpjs/inquiry_bpjs_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/menu/bpjs_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BpjsBloc extends Bloc<BpjsEvent, BpjsState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  BpjsState get initialState => BpjsInitial();

  @override
  Stream<BpjsState> mapEventToState(
    BpjsEvent event,
  ) async* {
    if (event is InquiryBpjsEvent) {
      yield* _inquiryBpjs(event);
    }
  }

  Stream<BpjsState> _inquiryBpjs(InquiryBpjsEvent event) async* {
    yield BpjsInitial();

    InquiryBpjsModel response;

    Map<String, dynamic> payload = {
      'family_va_number': event.familyVaNumber.trim(),
      'pay_until': event.payUntil.trim(),
    };

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await BpjsService().inquiryBpjs(payload);
      } else {
        response = await BpjsService().inquiryBpjs(payload);
      }

      yield GetInquiryBpjsSuccessState(data: response);
    } catch (err) {
      yield GetInquiryBpjsFailedState(
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
