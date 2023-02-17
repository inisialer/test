import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/payment/biller_payment_method_model.dart';
import 'package:alhikmah_app/model/payment/confirm_va_payment_model.dart';
import 'package:alhikmah_app/model/payment/confirm_zipay_payment_model.dart';
import 'package:alhikmah_app/model/payment/history_detail_biller_model.dart';
import 'package:alhikmah_app/model/payment/history_detail_pulsa_model.dart';
import 'package:alhikmah_app/model/payment/history_transaction_model.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/payment_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  PaymentState get initialState => PaymentInitial();

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    if (event is VaBankEvent) {
      yield* _vaBank(event);
    } else if (event is ConfirmVaPaymentEvent) {
      yield* _confirmVaPayment(event);
    } else if (event is ConfirmZipayPaymentEvent) {
      yield* _confirmZipayPayment(event);
    } else if (event is BillerPaymentMethodEvent) {
      yield* _billerPaymentMethod(event);
    } else if (event is SavingPaymentMethodEvent) {
      yield* _savingPaymentMethod(event);
    } else if (event is HistoryTransactionEvent) {
      yield* _historyTransaction(event);
    } else if (event is DetailHistoryBillerEvent) {
      yield* _historyDetailBiller(event);
    } else if (event is DetailHistoryPulsaEvent) {
      yield* _historyDetailPulsa(event);
    } else if (event is TagihanPaymentMethodEvent) {
      yield* _tagihanModalPayment(event);
    }
  }

  Stream<PaymentState> _vaBank(VaBankEvent event) async* {
    yield PaymentInitial();

    ItemVaBankModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PaymentService().vaBank();
      } else {
        response = await PaymentService().vaBank();
      }

      yield GetVaBankSuccessState(data: response);
    } catch (err) {
      yield GetVaBankFailedState(message: err?.response?.statusCode.toString());
    }
  }

  Stream<PaymentState> _confirmVaPayment(ConfirmVaPaymentEvent event) async* {
    yield PaymentInitial();

    Map<String, dynamic> payload = {
      'transaction_id': event.transactionId.trim(),
    };

    ConfirmVaPaymentModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PaymentService().confirmVaPayment(payload);
      } else {
        response = await PaymentService().confirmVaPayment(payload);
      }

      yield ConfirmVaPaymentSuccessState(data: response);
    } catch (err) {
      yield ConfirmVaPaymentFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PaymentState> _confirmZipayPayment(
      ConfirmZipayPaymentEvent event) async* {
    yield PaymentInitial();

    Map<String, dynamic> payload = {
      'transaction_id': event.transactionId.trim(),
      'zipay_pin': event.zipayPin.trim(),
    };

    ConfirmZipayPaymentModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PaymentService().confirmZipayPayment(payload);
      } else {
        response = await PaymentService().confirmZipayPayment(payload);
      }

      yield ConfirmZipayPaymentSuccessState(data: response);
    } on DioError catch (err) {
      if (err.type == DioErrorType.connectTimeout) {
        yield ConfirmZipayPaymentFailedState(message: 'timeout');
      } else {
        yield ConfirmZipayPaymentFailedState(
            message: err?.response?.statusCode.toString());
      }
    }
  }

  Stream<PaymentState> _billerPaymentMethod(
      BillerPaymentMethodEvent event) async* {
    yield PaymentInitial();

    Map<String, dynamic> payload = {
      'payment_method': event.paymentMethod.trim(),
      'transaction_id': event.transactionId.trim(),
      'va_bank_code': event.vaBankCode.trim(),
    };

    BillerPaymentMethodModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PaymentService().billerPaymentMethod(payload);
      } else {
        response = await PaymentService().billerPaymentMethod(payload);
      }

      yield BillerPaymentMethodSuccessState(data: response);
    } catch (err) {
      yield BillerPaymentMethodFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PaymentState> _historyTransaction(
      HistoryTransactionEvent event) async* {
    yield PaymentInitial();

    Map<String, dynamic> payload = {
      'start_date': event.startDate.trim(),
      'end_date': event.endDate.trim(),
      'sort_by': event.sortBy.trim(),
      'page': event.page,
      'per_page': event.perPage,
    };

    HistoryTransactionModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PaymentService().historyTransaction(payload);
      } else {
        response = await PaymentService().historyTransaction(payload);
      }

      yield HistoryTransactionSuccessState(
          data: response,
          startDate: event.startDate,
          endDate: event.endDate,
          sortBy: event.sortBy);
    } catch (err) {
      yield HistoryTransactionFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PaymentState> _historyDetailBiller(
      DetailHistoryBillerEvent event) async* {
    yield PaymentInitial();

    HistoryDetailBillerModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
            await PaymentService().historyDetailBiller(event.transactionId);
      } else {
        response =
            await PaymentService().historyDetailBiller(event.transactionId);
      }

      yield DetailHistoryBillerSuccessState(data: response);
    } catch (err) {
      yield DetailHistoryBillerFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<PaymentState> _historyDetailPulsa(
      DetailHistoryPulsaEvent event) async* {
    yield PaymentInitial();

    HistoryDetailPulsaModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
            await PaymentService().historyDetailPulsa(event.transactionId);
      } else {
        response =
            await PaymentService().historyDetailPulsa(event.transactionId);
      }

      yield DetailHistoryPulsaSuccessState(data: response);
    } catch (err) {
      yield DetailHistoryPulsaFailedState(
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

  // savings

  Stream<PaymentState> _savingPaymentMethod(
      SavingPaymentMethodEvent event) async* {
    yield PaymentInitial();

    Map<String, dynamic> payload = {
      'payment_method': event.paymentMethod.trim(),
      'transaction_id': event.transactionId.trim(),
      'va_bank_code': event.vaBankCode.trim(),
    };

    BillerPaymentMethodModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PaymentService().tabunganPaymentMethod(payload);
      } else {
        response = await PaymentService().tabunganPaymentMethod(payload);
      }

      yield BillerPaymentMethodSuccessState(data: response);
    } catch (err) {
      yield BillerPaymentMethodFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  // tagihan

  Stream<PaymentState> _tagihanModalPayment(
      TagihanPaymentMethodEvent event) async* {
    yield PaymentInitial();

    Map<String, dynamic> payload = {
      'payment_method': event.paymentMethod.trim(),
      'transaction_id': event.transactionId.trim(),
      'va_bank_code': event.vaBankCode.trim(),
    };

    BillerPaymentMethodModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await PaymentService().tagihanPaymentMethod(payload);
      } else {
        response = await PaymentService().tagihanPaymentMethod(payload);
      }

      yield BillerPaymentMethodSuccessState(data: response);
    } catch (err) {
      yield BillerPaymentMethodFailedState(
          message: err?.response?.statusCode.toString());
    }
  }
}
