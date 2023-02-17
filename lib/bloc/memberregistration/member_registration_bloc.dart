import 'dart:async';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/auth/refresh_token_model.dart';
import 'package:alhikmah_app/model/memberregistration/registration_member_model.dart';
import 'package:alhikmah_app/model/memberregistration/registration_submit_member_model.dart';
import 'package:alhikmah_app/model/memberregistration/success_registration_member_model.dart';
import 'package:alhikmah_app/service/auth_service.dart';
import 'package:alhikmah_app/service/member_registration_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class MemberRegistrationBloc
    extends Bloc<MemberRegistrationEvent, MemberRegistrationState> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  MemberRegistrationState get initialState => MemberRegistrationInitial();

  @override
  Stream<MemberRegistrationState> mapEventToState(
    MemberRegistrationEvent event,
  ) async* {
    if (event is RegistrationMemberEvent) {
      yield* _registrationMember(event);
    } else if (event is InitRegistrationMemberEvent) {
      yield* _initRegistrationMember(event);
    } else if (event is SecondRegistrationEmployeeEvent) {
      yield* _secondRegistrationEmployee(event);
    } else if (event is SecondRegistrationBusinessOwnerEvent) {
      yield* _secondRegistrationBusinessOwner(event);
    } else if (event is ThirdRegistrationEmployeeEvent) {
      yield* _thirdRegistrationEmployee(event);
    } else if (event is ThirdRegistrationBusinessOwnerEvent) {
      yield* _thirdRegistrationBusinessOwner(event);
    } else if (event is AccountRegistrationMemberEvent) {
      yield* _accountRegistrationMember(event);
    } else if (event is SubmitRegistrationMemberEvent) {
      yield* _submitRegistrationMember(event);
    }
  }

  Stream<MemberRegistrationState> _registrationMember(RegistrationMemberEvent event) async* {
    yield MemberRegistrationInitial();

    RegistrationMemberModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MemberRegistrationService().getRegistration();
      } else {
        response = await MemberRegistrationService().getRegistration();
      }

      yield RegistrationMemberSuccessState(data: response);
    } catch (err) {
      yield RegistrationMemberFailedState(message: "");
    }
  }

  Stream<MemberRegistrationState> _initRegistrationMember(
      InitRegistrationMemberEvent event) async* {
    yield MemberRegistrationInitial();

    SuccessRegistrationMemberModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response =
            await MemberRegistrationService().initRegistration(event.payload);
      } else {
        response =
            await MemberRegistrationService().initRegistration(event.payload);
      }

      yield InitRegistrationMemberSuccessState(
          data: response, jobType: event.payload.jobType.trim());
    } catch (err) {
      yield InitRegistrationMemberFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MemberRegistrationState> _secondRegistrationEmployee(
      SecondRegistrationEmployeeEvent event) async* {
    yield MemberRegistrationInitial();

    SuccessRegistrationMemberModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MemberRegistrationService()
            .secondRegistrationEmployee(event.payload);
      } else {
        response = await MemberRegistrationService()
            .secondRegistrationEmployee(event.payload);
      }

      yield SecondRegistrationEmployeeSuccessState(data: response);
    } catch (err) {
      yield SecondRegistrationEmployeeFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MemberRegistrationState> _secondRegistrationBusinessOwner(
      SecondRegistrationBusinessOwnerEvent event) async* {
    yield MemberRegistrationInitial();

    SuccessRegistrationMemberModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MemberRegistrationService()
            .secondRegistrationBusinessOwner(event.payload);
      } else {
        response = await MemberRegistrationService()
            .secondRegistrationBusinessOwner(event.payload);
      }

      yield SecondRegistrationBusinessOwnerSuccessState(data: response);
    } catch (err) {
      yield SecondRegistrationBusinessOwnerFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MemberRegistrationState> _thirdRegistrationEmployee(
      ThirdRegistrationEmployeeEvent event) async* {
    yield MemberRegistrationInitial();

    SuccessRegistrationMemberModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MemberRegistrationService()
            .thirdRegistrationEmployee(event.payload);
      } else {
        response = await MemberRegistrationService()
            .thirdRegistrationEmployee(event.payload);
      }

      yield ThirdRegistrationEmployeeSuccessState(data: response);
    } catch (err) {
      yield ThirdRegistrationEmployeeFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MemberRegistrationState> _thirdRegistrationBusinessOwner(
      ThirdRegistrationBusinessOwnerEvent event) async* {
    yield MemberRegistrationInitial();

    SuccessRegistrationMemberModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MemberRegistrationService()
            .thirdRegistrationBusinessOwner(event.payload);
      } else {
        response = await MemberRegistrationService()
            .thirdRegistrationBusinessOwner(event.payload);
      }

      yield ThirdRegistrationBusinessOwnerSuccessState(data: response);
    } catch (err) {
      yield ThirdRegistrationBusinessOwnerFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MemberRegistrationState> _accountRegistrationMember(
      AccountRegistrationMemberEvent event) async* {
    yield MemberRegistrationInitial();

    SuccessRegistrationMemberModel response;
    Map<String, dynamic> payload = {
      'account_bank_code': event.accountBankCode.trim(),
      'account_holder_name': event.accountHolderName.trim(),
      'account_number': event.accountNumber.trim()
    };

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MemberRegistrationService()
            .accountRegistrationMember(payload);
      } else {
        response = await MemberRegistrationService()
            .accountRegistrationMember(payload);
      }

      yield AccountRegistrationMemberSuccessState(data: response);
    } catch (err) {
      yield AccountRegistrationMemberFailedState(
          message: err?.response?.statusCode.toString());
    }
  }

  Stream<MemberRegistrationState> _submitRegistrationMember(
      SubmitRegistrationMemberEvent event) async* {
    yield MemberRegistrationInitial();

    RegistrationSubmitMemberModel response;

    try {
      if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
          DateTime.now().millisecondsSinceEpoch) {
        await checkRefreshToken();
        response = await MemberRegistrationService().submitRegistrationMember();
      } else {
        response = await MemberRegistrationService().submitRegistrationMember();
      }

      yield SubmitRegistrationMemberSuccessState(data: response);
    } catch (err) {
      yield SubmitRegistrationMemberFailedState(
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
