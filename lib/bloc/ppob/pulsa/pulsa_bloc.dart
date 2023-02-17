import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/inquiry_pulsa_pascabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/item_paket_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/item_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/phone_provider_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/recent_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/recent_pulsa_prabayar_phone_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/request_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/menu/pulsa_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class PulsaBloc extends Bloc<PulsaEvent, PulsaState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  PulsaState get initialState => PulsaInitial();

  @override
  Stream<PulsaState> mapEventToState(
    PulsaEvent event,
  ) async* {
    if (event is PhoneProviderEvent) {
      yield* _phonePrabayar(event);
    } else if (event is ItemPulsaPrabayarEvent) {
      yield* _itemPulsaPrabayar(event);
    } else if (event is ItemPaketPrabayarEvent) {
      yield* _itemPaketPrabayar(event);
    } else if (event is RecentPulsaPrabayarEvent) {
      yield* _recentPulsaPrabayar(event);
    } else if (event is RecentPulsaPrabayarPhoneEvent) {
      yield* _recentPulsaPrabayarPhone(event);
    } else if (event is RequestPulsaPrabayarEvent) {
      yield* _requestPulsaPrabayar(event);
    } else if (event is InquiryPulsaPascabayarEvent) {
      yield* _inquiryPulsaPascabayar(event);
    }
  }

  Stream<PulsaState> _phonePrabayar(PhoneProviderEvent event) async* {
    yield PulsaInitial();

    PhoneProviderModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PulsaService().phoneProvider(event.code);
      } else {
        response = await PulsaService().phoneProvider(event.code);
      }

      yield GetPhoneProviderSuccessState(data: response);
    } catch (err) {
      yield GetPhoneProviderFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PulsaState> _itemPulsaPrabayar(ItemPulsaPrabayarEvent event) async* {
    yield PulsaInitial();

    ItemPulsaPrabayarModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PulsaService().itemPulsaPrabayar(event.provider);
      } else {
        response = await PulsaService().itemPulsaPrabayar(event.provider);
      }

      yield GetItemPulsaPrabayarSuccessState(data: response);
    } catch (err) {
      yield GetItemPulsaPrabayarFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PulsaState> _itemPaketPrabayar(ItemPaketPrabayarEvent event) async* {
    yield PulsaInitial();

    ItemPaketPrabayarModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PulsaService().itemPaketPrabayar(event.provider);
      } else {
        response = await PulsaService().itemPaketPrabayar(event.provider);
      }

      yield GetItemPaketPrabayarSuccessState(data: response);
    } catch (err) {
      yield GetItemPaketPrabayarFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PulsaState> _recentPulsaPrabayar(RecentPulsaPrabayarEvent event) async* {
    yield PulsaInitial();

    RecentPulsaPrabayarModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PulsaService().recentPulsaPrabayar();
      } else {
        response = await PulsaService().recentPulsaPrabayar();
      }

      yield GetRecentPulsaPrabayarSuccessState(data: response);
    } catch (err) {
      yield GetRecentPulsaPrabayarFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PulsaState> _recentPulsaPrabayarPhone(RecentPulsaPrabayarPhoneEvent event) async* {
    yield PulsaInitial();

    RecentPulsaPrabayarPhoneModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PulsaService().recentPulsaPrabayarPhone();
      } else {
        response = await PulsaService().recentPulsaPrabayarPhone();
      }

      yield GetRecentPulsaPrabayarPhoneSuccessState(data: response);
    } catch (err) {
      yield GetRecentPulsaPrabayarPhoneFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PulsaState> _requestPulsaPrabayar(RequestPulsaPrabayarEvent event) async* {
    yield PulsaInitial();

    Map<String, dynamic> payload = {
      'payment_method': event.paymentMethod.trim(),
      'phone_number': event.phoneNumber.trim(),
      'product_code': event.productCode,
      'va_bank_code': event.vaBankCode.trim(),
    };

    RequestPulsaPrabayarModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PulsaService().requestPulsaPrabayar(payload);
      } else {
        response = await PulsaService().requestPulsaPrabayar(payload);
      }

      yield RequestPulsaPrabayarSuccessState(data: response);
    } catch (err) {
      yield RequestPulsaPrabayarFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PulsaState> _inquiryPulsaPascabayar(InquiryPulsaPascabayarEvent event) async* {
    yield PulsaInitial();

    InquiryPulsaPascabayarModel response;

    Map<String, dynamic> payload = {
      'phone_number': event.phoneNumber.trim(),
    };

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PulsaService().inquiryPulsaPascabayar(payload);
      } else {
        response = await PulsaService().inquiryPulsaPascabayar(payload);
      }

      yield GetInquiryPulsaPascabayarSuccessState(data: response);
    } catch (err) {
      yield GetInquiryPulsaPascabayarFailedState(
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
