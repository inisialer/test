import 'dart:developer';

import 'package:alhikmah_app/bloc/auth/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/screen/auth/checkotp/check_otp_screen.dart';
import 'package:alhikmah_app/screen/auth/checkpin/check_pin_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';

class CheckPhoneScreen extends StatefulWidget {
  const CheckPhoneScreen({Key key}) : super(key: key);

  @override
  _CheckPhoneScreenState createState() => _CheckPhoneScreenState();
}

class _CheckPhoneScreenState extends State<CheckPhoneScreen> {
  AuthBloc _authBloc;
  final _screen = ScreenUtil();
  SharedPreferences _prefs = App().sharedPreferences;

  TextEditingController _noPhone = TextEditingController();

  String errValidate = "";

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is CheckUserSuccessState) {
          var phone = _noPhone.text;
          if (phone[0] == '0') {
            final repReg = RegExp(r'\d{1}');
            phone = phone.replaceFirst(repReg, '');
          } else if ((phone[0] + phone[1]) == '62') {
            final repReg = RegExp(r'\d{2}');
            phone = phone.replaceFirst(repReg, '');
          }
          if (state.data.data.isRegistered &&
              state.data.data.isPhoneNumberVerified) {
            EasyLoading.dismiss();
            var data = {
              'isSetPin': true,
              'phone': phone,
              'isLogin': (_prefs.getBool(SharePrefs.IS_LOGIN) == null ||
                      _prefs.getBool(SharePrefs.IS_LOGIN) == false)
                  ? false
                  : true
            };
            MyNavigator.goToCheckPin(context, CheckPinArguments(data));

          } else if (state.data.data.isRegistered &&
              !state.data.data.isPhoneNumberVerified) {
            var data = {
              'phone': phone,
              'isRegister': true,
            };
            MyNavigator.goToCheckOtp(context, CheckOtpArguments(data));
            _authBloc.add(ResendOtpEvent(phone: phone));
          } else {
            EasyLoading.dismiss();
            AppUtil().hideKeyboard(context);
            var data = {
              'isSetPin': false,
              'phone': phone,
              'isLogin':
                  (_prefs.getBool(SharePrefs.IS_LOGIN) == null) ? false : true
            };

            MyNavigator.goToConfirmationScreen(context, CheckPinArguments(data));
          }
          _prefs.setString(SharePrefs.PHONE, phone);
        } else if (state is CheckUserFailedState) {
          log("failed");
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: ListView(
              children: [
                SizedBox(height: _screen.heightDefault(context) / 20),
                Image.asset(Images.LOGO_ALHIKMAH),
                SizedBox(height: _screen.heightDefault(context) / 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 10),
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.all(_screen.widthDefault(context) / 24),
                        decoration: BoxDecoration(
                          color:
                              AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
                          borderRadius: BorderRadius.circular(72),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/icon/ic_flag.png'),
                            SizedBox(width: _screen.widthDefault(context) / 50),
                            Text(
                              '+62',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.CHARCOAL)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: _screen.widthDefault(context) / 50),
                      Expanded(
                          child: Column(
                        children: [
                          TextField(
                            controller: _noPhone,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppUtil()
                                    .parseHexColor(CustomColors.CHARCOAL)),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(13),
                            ],
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppUtil()
                                  .parseHexColor(CustomColors.WHITE_SMOKE),
                              contentPadding: EdgeInsets.all(
                                  _screen.widthDefault(context) / 24),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(72),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(72),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          if (errValidate.isNotEmpty)
                            Text(errValidate, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,)
                        ],
                      )),
                    ],
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 18),
                Column(
                  children: [
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _noPhone,
                        builder: (context, value, child) {
                          return CustomButtonRaised(
                            onTap: () async {
                              if (_noPhone.text.isEmpty || _noPhone.text.length < 5){
                                setState(() {
                                  errValidate = "Phone number is to short";
                                });
                              }else{
                                _noPhone.text.isNotEmpty
                                    ? await _sendOtp()
                                    : print('Not yet');
                              }
                            },
                            title: 'Lanjut',
                            isCompleted: _noPhone.text.isNotEmpty,
                          );
                        }),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _sendOtp() {
    AppUtil().hideKeyboard(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );

    _authBloc.add(CheckUserEvent(phone: _noPhone.text));
  }
}
