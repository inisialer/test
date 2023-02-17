import 'dart:async';

import 'package:alhikmah_app/bloc/auth/bloc.dart';
import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({Key key}) : super(key: key);

  @override
  _ChangePinScreenState createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  AuthBloc _authBloc;
  UserBloc _userBloc;
  SharedPreferences _prefs = App().sharedPreferences;
  final _screen = ScreenUtil();
  TextEditingController _otp = TextEditingController();
  TextEditingController _pin = TextEditingController();
  TextEditingController _confirmPin = TextEditingController();
  bool _isCompletedOtp = false;
  bool _isCompletedPin = false;
  bool _isCompleteConfirmPin = false;
  String _currentOtp = '';
  String _currentPIN = '';
  String _currentConfirmPIN = '';

  Timer _countdownTimer;
  int _timeCountdown = 60;
  String _timeString = '01:00';

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChangePinArguments args = ModalRoute.of(context).settings.arguments;

    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(listener: (context, state) {
          if (state is GetMeSuccessState) {
            EasyLoading.dismiss();
            if (state.data.data.firstName != null &&
                state.data.data.lastName != null) {
              _prefs.setString(SharePrefs.NAME,
                  state.data.data.firstName + ' ' + state.data.data.lastName);
            } else {
              _prefs.setString(SharePrefs.NAME, '');
            }

            if (state.data.data.profilePhoto != null) {
              _prefs.setString(
                  SharePrefs.PHOTO_PROFILE, state.data.data.profilePhoto);
            } else {
              _prefs.setString(SharePrefs.PHOTO_PROFILE, '');
            }

            MyNavigator.goToMain(context);
            _countdownTimer.cancel();
          } else if (state is GetMeFailedState) {
            EasyLoading.dismiss();
          }
        }),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ChangePinSuccessState) {
              _prefs.setString(
                  SharePrefs.ACCESS_TOKEN, state.data.data.accessToken);
              _prefs.setString(
                  SharePrefs.REFRESH_TOKEN, state.data.data.refreshToken);
              _prefs.setInt(
                  SharePrefs.EXPIRES_TOKEN, state.data.data.expiresAt);
              _userBloc.add(MeEvent());
            } else if (state is ChangePinFailedState) {
              EasyLoading.dismiss();
              setState(() {
                _otp.text = '';
                _pin.text = '';
                _confirmPin.text = '';
                _currentOtp = '';
                _currentPIN = '';
                _currentConfirmPIN = '';
              });
            } else if (state is ForgotPinSuccessState) {
              EasyLoading.dismiss();
              _timeCountdown = 60;
              _startTimer();
            } else if (state is ForgotPinFailedState) {
              EasyLoading.dismiss();
            }
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: ListView(
              children: [
                SizedBox(height: _screen.heightDefault(context) / 20),
                Image.asset(Images.LOGO_ALHIKMAH),
                Center(
                  child: Text(
                    'Kode OTP Telah dikirimkan ke\n+62 ${args.data['phone']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppUtil().parseHexColor(CustomColors.CHARCOAL),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 4.5),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: AppUtil().parseHexColor(CustomColors.NOBEL),
                      disabledColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      activeFillColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      selectedColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      inactiveColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      fieldWidth: _screen.widthDefault(context) / 14,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.go,
                    animationDuration: Duration(milliseconds: 300),
                    controller: _otp,
                    onCompleted: (v) {
                      setState(() {
                        _isCompletedOtp = true;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        if (value.length < 6) _isCompletedOtp = false;
                        _currentOtp = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 30),
                Center(
                  child: Text(
                    'PIN Baru',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppUtil().parseHexColor(CustomColors.CHARCOAL),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 4.5),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: AppUtil().parseHexColor(CustomColors.NOBEL),
                      disabledColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      activeFillColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      selectedColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      inactiveColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      fieldWidth: _screen.widthDefault(context) / 14,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.go,
                    animationDuration: Duration(milliseconds: 300),
                    controller: _pin,
                    onCompleted: (v) {
                      setState(() {
                        _isCompletedPin = true;
                      });
                    },
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {
                          if (value.length < 6) _isCompletedPin = false;
                          _currentPIN = value;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 30),
                Center(
                  child: Text(
                    'Konfirmasi Pin anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppUtil().parseHexColor(CustomColors.CHARCOAL),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 4.5),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: AppUtil().parseHexColor(CustomColors.NOBEL),
                      disabledColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      activeFillColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      selectedColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      inactiveColor:
                          AppUtil().parseHexColor(CustomColors.NOBEL),
                      fieldWidth: _screen.widthDefault(context) / 14,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.go,
                    animationDuration: Duration(milliseconds: 300),
                    controller: _confirmPin,
                    onCompleted: (v) {
                      setState(() {
                        _isCompleteConfirmPin = true;
                      });
                    },
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {
                          if (value.length < 6) _isCompleteConfirmPin = false;
                          _currentConfirmPIN = value;
                        });
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_timeCountdown == 0) _resendOtp(args.data['phone']);
                  },
                  child: Center(
                    child: Text(
                      (_timeCountdown == 0)
                          ? 'Kirim Ulang OTP'
                          : '(Kirim Ulang OTP $_timeString)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: (_timeCountdown == 0)
                              ? AppUtil().parseHexColor(CustomColors.MORTAR)
                              : AppUtil().parseHexColor(CustomColors.SILVER),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 24),
                Column(
                  children: [
                    CustomButtonRaised(
                      title: 'Lanjut',
                      isCompleted: _isCompletedOtp &&
                          _isCompleteConfirmPin &&
                          _isCompletedPin &&
                          _isCompleteConfirmPin == _isCompletedPin,
                      onTap: () async {
                        _isCompletedOtp &&
                                _isCompleteConfirmPin &&
                                _isCompletedPin &&
                                _currentConfirmPIN == _currentPIN
                            ? await _verifyOtp(args.data['phone'])
                            : print('Not yet');
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _startTimer() {
    _countdownTimer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        if (_timeCountdown == 0) {
          setState(() {
            t.cancel();
          });
        } else {
          setState(() {
            _timeCountdown--;
            var date =
                DateTime.fromMillisecondsSinceEpoch(_timeCountdown * 1000);
            final String formattedDateTime = DateFormat('mm:ss').format(date);
            _timeString = formattedDateTime;
          });
        }
      },
    );
  }

  _verifyOtp(String phone) {
    AppUtil().hideKeyboard(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );

    _authBloc
        .add(ChangePinEvent(phone: phone, otp: _currentOtp, pin: _currentPIN));
  }

  _resendOtp(String phone) {
    AppUtil().hideKeyboard(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _authBloc.add(ForgotPinEvent(phone: phone));
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }
}

class ChangePinArguments {
  final dynamic data;

  ChangePinArguments(this.data);
}
