import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/user/balance_model.dart';
import 'package:alhikmah_app/model/user/me_model.dart';
import 'package:alhikmah_app/model/user/verify_pin_model.dart';
import 'package:alhikmah_app/model/user/virtual_account_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/user_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is MeEvent) {
      yield* _me(event);
    } else if (event is VerifyPinEvent) {
      yield* _verifyPin(event);
    } else if (event is BalanceEvent) {
      yield* _balance(event);
    } else if (event is VaZipayEvent) {
      yield* _vaZipay(event);
    }
  }

  Stream<UserState> _me(MeEvent event) async* {
    yield UserInitial();

    MeModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await UserService().me();
      } else {
        response = await UserService().me();
      }

      yield GetMeSuccessState(data: response);
    } catch (err) {
      yield GetMeFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<UserState> _verifyPin(VerifyPinEvent event) async* {
    yield UserInitial();

    Map<String, dynamic> payload = {
      'pin': event.pin.trim(),
    };

    VerifyPinModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await UserService().verifyPin(payload);
      } else {
        response = await UserService().verifyPin(payload);
      }

      yield VerifyPinSuccessState(data: response);
    } catch (err) {
      yield VerifyPinFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<UserState> _balance(BalanceEvent event) async* {
    yield UserInitial();

    BalanceModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await UserService().balance();
      } else {
        response = await UserService().balance();
      }

      yield GetBalanceSuccessState(data: response, state: event.state);
    } catch (err) {
      yield GetBalanceFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<UserState> _vaZipay(VaZipayEvent event) async* {
    yield UserInitial();

    VirtualAccountModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await UserService().vaZipay();
      } else {
        response = await UserService().vaZipay();
      }

      yield GetVaZipaySuccessState(data: response);
    } catch (err) {
      yield GetVaZipayFailedState(
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
