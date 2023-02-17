import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/util/convert_base_64_model.dart';
import 'package:alhikmah_app/model/util/upload_private_model.dart';
import 'package:alhikmah_app/model/util/upload_public_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/util_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilBloc extends Bloc<UtilEvent, UtilState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  UtilState get initialState => UtilInitial();

  @override
  Stream<UtilState> mapEventToState(
    UtilEvent event,
  ) async* {
    if (event is UploadPrivateEvent) {
      yield* _uploadPrivate(event);
    } else if (event is UploadPublicEvent) {
      yield* _uploadPublic(event);
    } else if (event is SetDropdownEvent) {
      yield* _setDropdown(event);
    } else if(event is UploadConvertEvent) {
      yield* _convertUpload(event);
    }
  }

  Stream<UtilState> _convertUpload(UploadConvertEvent event) async* {
    yield UtilInitial();

    ConvertBase64Model response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
        await UtilService().uploadConvert(event.file);
      } else {
        response =
        await UtilService().uploadConvert(event.file);
      }

      yield UploadConvertSuccessState(data: response);
    } catch (err) {
      yield UploadConvertFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<UtilState> _uploadPrivate(UploadPrivateEvent event) async* {
    yield UtilInitial();

    UploadPrivateModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
            await UtilService().uploadPrivate(event.file, event.category);
      } else {
        response =
            await UtilService().uploadPrivate(event.file, event.category);
      }

      yield UploadPrivateSuccessState(data: response);
    } catch (err) {
      yield UploadPrivateFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<UtilState> _uploadPublic(UploadPublicEvent event) async* {
    yield UtilInitial();

    UploadPublicModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await UtilService().uploadPublic(event.file, event.category);
      } else {
        response = await UtilService().uploadPublic(event.file, event.category);
      }

      yield UploadPublicSuccessState(data: response);
    } catch (err) {
      yield UploadPrivateFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<UtilState> _setDropdown(SetDropdownEvent event) async* {
    yield UtilInitial();

    yield SetDropdownState(item: event.item, category: event.category);
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
