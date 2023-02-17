import 'dart:convert';

import 'package:alhikmah_app/data/endpoint.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/payment/biller_payment_method_model.dart';
import 'package:alhikmah_app/model/payment/confirm_va_payment_model.dart';
import 'package:alhikmah_app/model/payment/confirm_zipay_payment_model.dart';
import 'package:alhikmah_app/model/payment/history_detail_biller_model.dart';
import 'package:alhikmah_app/model/payment/history_detail_pulsa_model.dart';
import 'package:alhikmah_app/model/payment/history_transaction_model.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';

class PaymentService {
  Dio _dio = App().dio;
  SharedPreferences _prefs = App().sharedPreferences;

  Future<ItemVaBankModel> vaBank() async {
    Response response = await _dio.get(Endpoint.vaBank,
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ItemVaBankModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<BillerPaymentMethodModel> billerPaymentMethod(
      Map<String, dynamic> payload) async {
    var data = {
      'payment_method': payload['payment_method'],
      'transaction_id': payload['transaction_id'],
      'va_bank_code': payload['va_bank_code'],
    };
    Response response = await _dio.post(Endpoint.paymentMethodBiller,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return BillerPaymentMethodModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ConfirmVaPaymentModel> confirmVaPayment(
      Map<String, dynamic> payload) async {
    var data = {
      'transaction_id': payload['transaction_id'],
    };
    Response response = await _dio.post(Endpoint.confirmPaymentVa,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ConfirmVaPaymentModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<ConfirmZipayPaymentModel> confirmZipayPayment(
      Map<String, dynamic> payload) async {
    var data = {
      'transaction_id': payload['transaction_id'],
      'zipay_pin': payload['zipay_pin'],
    };
    Response response = await _dio.post(Endpoint.confirmPaymentZipay,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return ConfirmZipayPaymentModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<HistoryTransactionModel> historyTransaction(
      Map<String, dynamic> payload) async {
    Response response = await _dio.get(Endpoint.historyTransaction,
        queryParameters: {
          'start_date': payload['start_date'],
          'end_date': payload['end_date'],
          'sort_by': payload['sort_by'],
          'page': payload['page'],
          'per_page': payload['per_page']
        },
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return HistoryTransactionModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<HistoryDetailBillerModel> historyDetailBiller(
      String transactionId) async {
    Response response =
        await _dio.get(Endpoint.historyDetailBiller(transactionId),
            options: Options(
              headers: {
                'authorization':
                    'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
              },
            ));

    if (response.statusCode == 200) {
      return HistoryDetailBillerModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<HistoryDetailPulsaModel> historyDetailPulsa(
      String transactionId) async {
    Response response =
        await _dio.get(Endpoint.historyDetailPulsa(transactionId),
            options: Options(
              headers: {
                'authorization':
                    'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
              },
            ));

    if (response.statusCode == 200) {
      return HistoryDetailPulsaModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  // savings

  Future<BillerPaymentMethodModel> tabunganPaymentMethod(
      Map<String, dynamic> payload) async {
    var data = {
      'payment_method': payload['payment_method'],
      'transaction_id': payload['transaction_id'],
      'va_bank_code': payload['va_bank_code'],
    };
    Response response = await _dio.post(Endpoint.tabunganPaymentMethod,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return BillerPaymentMethodModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<BillerPaymentMethodModel> tagihanPaymentMethod(
      Map<String, dynamic> payload) async {
    var data = {
      'payment_method': payload['payment_method'],
      'transaction_id': payload['transaction_id'],
      'va_bank_code': payload['va_bank_code'],
    };
    Response response = await _dio.post("capital-loan/payment-method",
        data: jsonEncode(data),
        options: Options(
          headers: {
            'authorization':
                'Bearer ' + _prefs.getString(SharePrefs.ACCESS_TOKEN)
          },
        ));

    if (response.statusCode == 200) {
      return BillerPaymentMethodModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
