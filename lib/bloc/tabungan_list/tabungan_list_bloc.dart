import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/model/tabungan/check_tagihan_saving_model.dart';
import 'package:alhikmah_app/model/tabungan/tabungan_list_model.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/data/response_tagihan_inquiry.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/service/capital_loan_service.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/tabungan/tabungan_list_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/shared_preferences.dart';
import '../../model/auth/refresh_token_model.dart';
import '../../util/app_util.dart';

part 'tabungan_list_event.dart';
part 'tabungan_list_state.dart';

class TabunganListBloc extends Bloc<TabunganListEvent, TabunganListState> {
  @override
  TabunganListState get initialState => TabunganListInitial();
  SharedPreferences _prefs = App().sharedPreferences;
  var response;
  @override
  Stream<TabunganListState> mapEventToState(
    TabunganListEvent event,
  ) async* {
    if (event is TabunganListGet) {
      yield* getList(event);
    }
    if (event is TabunganCheckPayment) {
      yield* checkTabunganPayment(event);
    }
    if (event is PostTagihanResponseInquiry) {
      yield* checkTagihanInquiry(event);
    }
  }

  Stream<TabunganListState> getList(TabunganListGet event) async* {
    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await TabunganListService().getList();
        if (response is TabunganListModel) {
          yield TabunganListLoaded(tabunganListModel: response);
        } else {
          yield TabunganListError(error: "Error");
        }
      } else {
        response = await TabunganListService().getList();
        yield TabunganListLoaded(tabunganListModel: response);
      }
    } catch (e) {
      yield TabunganListError(error: e);
    }
  }

  Stream<TabunganListState> checkTabunganPayment(
      TabunganCheckPayment event) async* {
    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
            await TabunganListService().getCheckTagihan(event.savingType);
        yield TabunganCheckPaymentLoaded(checkTagihanSavingModel: response);
      } else {
        response =
            await TabunganListService().getCheckTagihan(event.savingType);
        yield TabunganCheckPaymentLoaded(checkTagihanSavingModel: response);
      }
    } catch (e) {
      yield TabunganListError(error: e);
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

  // tagihan

  Stream<TabunganListState> checkTagihanInquiry(
      PostTagihanResponseInquiry event) async* {
    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await CapitalLoanService().responseTagihanInquiry(event.id);
        yield TagihanInquiryPaymentLoaded(responseTagihanInquiry: response);
      } else {
        response = await CapitalLoanService().responseTagihanInquiry(event.id);
        yield TagihanInquiryPaymentLoaded(responseTagihanInquiry: response);
      }
    } catch (e) {
      yield TabunganListError(error: e);
    }
  }
}
