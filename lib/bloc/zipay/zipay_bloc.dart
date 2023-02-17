import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/zipay/bloc.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/zipay/zipay_check_kyc_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_history_model.dart';
import 'package:alhikmah_app/model/zipay/zipay_update_kyc_model.dart';
import 'package:alhikmah_app/service/zipay_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/auth/refresh_token_model.dart';
import '../../model/zipay/zipay_va_model.dart';
import '../../service/auth_service.dart';

class ZipayBloc extends Bloc<ZipayEvent, ZipayState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  ZipayState get initialState => ZipayInitial();

  @override
  Stream<ZipayState> mapEventToState(
      ZipayEvent event,
      ) async* {
    if(event is TransactionHistoryEvent){
      yield* _transactionHistory(event);
    }else if(event is TransactionVAEvent){
      yield* _transactionVA(event);
    }else if(event is StatusKYCEvent){
      yield* _checkStatusKyc(event);
    }else if(event is UpdateKYCEvent){
      yield* _updateStatusKyc(event);
    }
  }

  Stream<ZipayState> _transactionHistory(TransactionHistoryEvent event) async*{
    yield ZipayInitial();

    ZipayHistoryModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
        await ZipayService().historyZipay();
      } else {
        response =
        await ZipayService().historyZipay();
      }

      yield TransactionHistorySuccessState(data: response);
    } catch (err) {
      yield TransactionHistoryFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<ZipayState> _transactionVA(TransactionVAEvent event) async*{
    yield ZipayInitial();

    ZipayVAModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
        await ZipayService().getVA();
      } else {
        response =
        await ZipayService().getVA();
      }

      yield TransactionVASuccessState(data: response);
    } catch (err) {
      yield TransactionVAFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<ZipayState> _checkStatusKyc(StatusKYCEvent event) async*{
    yield ZipayInitial();

    ZipayCheckKYCModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
        await ZipayService().checkStatusKyc();
      } else {
        response =
        await ZipayService().checkStatusKyc();
      }

      yield StatusKYCSuccessState(data: response);
    } catch (err) {
      yield StatusKYCFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<ZipayState> _updateStatusKyc(UpdateKYCEvent event) async*{
    yield ZipayInitial();

    Map<String, dynamic> payload = {
      'selfie': event.selfie,
      'id_card': event.idCard,
    };

    ZipayUpdateKYCModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
        await ZipayService().updateKyc(payload);
      } else {
        response =
        await ZipayService().updateKyc(payload);
      }

      yield UpdateKYCSuccessState(data: response);
    } catch (err) {
      yield UpdateKYCFailedState(
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