import 'package:alhikmah_app/bloc/auth/bloc.dart';
import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/screen/auth/changepin/change_pin_screen.dart';
import 'package:alhikmah_app/screen/auth/checkprofile/check_profile_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';

class CheckPinScreen extends StatefulWidget {
  const CheckPinScreen({Key key}) : super(key: key);

  @override
  _CheckPinScreenState createState() => _CheckPinScreenState();
}

class _CheckPinScreenState extends State<CheckPinScreen> {
  AuthBloc _authBloc;
  UserBloc _userBloc;
  SharedPreferences _prefs = App().sharedPreferences;
  final _screen = ScreenUtil();
  TextEditingController _pin = TextEditingController();
  bool _isCompletedPin = false;
  String _currentPin = '';
  bool _isVerifyPin = false;
  String _currentVerifyPin = '';

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CheckPinArguments args = ModalRoute
        .of(context)
        .settings
        .arguments;
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
            _prefs.setBool(SharePrefs.IS_LOGIN, true);
            MyNavigator.goToMain(context);
          } else if (state is GetMeFailedState) {
            EasyLoading.dismiss();
          } else if (state is VerifyPinSuccessState) {
            EasyLoading.dismiss();
            if (state.data.data.isPinMatch) {
              MyNavigator.goToMain(context);
            } else {
              AppUtil.showToast('PIN Salah, Silahkan ulangi');
              _currentPin = '';
              _pin.text = '';
            }
          } else if (state is VerifyPinFailedState) {
            if (state.message == '401') {
              MyNavigator.goToCheckPhone(context);
              _prefs.setBool(SharePrefs.IS_LOGIN, false);
            }
            EasyLoading.dismiss();
          }
        }),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              _prefs.setString(
                  SharePrefs.ACCESS_TOKEN, state.data.data.accessToken);
              _prefs.setString(
                  SharePrefs.REFRESH_TOKEN, state.data.data.refreshToken);
              _prefs.setInt(
                  SharePrefs.EXPIRES_TOKEN, state.data.data.expiresAt);
              _userBloc.add(MeEvent());
            } else if (state is LoginFailedState) {
              EasyLoading.dismiss();
              AppUtil.showToast('PIN Salah, Silahkan ulangi');
              _currentPin = '';
              _pin.text = '';
            } else if (state is ForgotPinSuccessState) {
              EasyLoading.dismiss();
              MyNavigator.goToChangePin(context, ChangePinArguments({"phone": _prefs.getString(SharePrefs.PHONE), "isRegister": true}));
            } else if (state is ForgotPinFailedState) {
              EasyLoading.dismiss();
              AppUtil.showToast('Terjadi kesalahan saat ingin mengubah pin');
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
                    args.data['isSetPin']
                        ? 'Masukkan PIN Anda'
                        : (!args.data['isSetPin'] && !_isVerifyPin)
                        ? 'Buat PIN Anda'
                        : 'Konfirmasi PIN Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppUtil().parseHexColor(CustomColors.CHARCOAL),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 30),
                Container(
                  height: _screen.heightDefault(context) / 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE)),
                  padding: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 10),
                  margin: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 8),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor:
                      AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      disabledColor:
                      AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      activeFillColor:
                      AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      selectedColor:
                      AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      inactiveColor:
                      AppUtil().parseHexColor(CustomColors.GAINSBORO),
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
                      setState(() {
                        if (value.length < 6) _isCompletedPin = false;
                        _currentPin = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 30),
                if(args.data["isSetPin"])
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _forgotPassword(_prefs.getString(SharePrefs.PHONE));
                        },
                        child: Text("Lupa PIN ?"),
                      )
                    ],
                  ),
                SizedBox(height: _screen.heightDefault(context) / 18),
                Column(
                  children: [
                    CustomButtonRaised(
                      isCompleted: _isCompletedPin,
                      title: 'Lanjut',
                      onTap: () {
                        setState(() {
                          if (_isCompletedPin) {
                            if (args.data['isSetPin']) {
                              if (args.data['isLogin']) {
                                _inputPin();
                              } else {
                                _verifyPin(_prefs.getString(SharePrefs.PHONE));
                              }
                            } else {
                              if (!_isVerifyPin) {
                                _isVerifyPin = true;
                                _currentVerifyPin = _currentPin;
                                _pin.text = '';
                                _currentPin = '';
                              } else {
                                if (_isVerifyPin &&
                                    (_currentPin == _currentVerifyPin)) {
                                  _setPin(_prefs.getString(SharePrefs.PHONE));
                                } else {
                                  AppUtil.showToast('Pin tidak sesuai');
                                  _pin.text = '';
                                  _currentPin = '';
                                }
                              }
                            }
                          }
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _setPin(String phone) {
    var data = {
      'phone': phone,
      'pin': _currentVerifyPin,
    };
    MyNavigator.goToCheckProfile(context, CheckProfileArguments(data));
  }

  _forgotPassword(String phone) {
    AppUtil().hideKeyboard(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _authBloc.add(ForgotPinEvent(
      phone: phone,
    ));
  }

  _verifyPin(String phone) {
    AppUtil().hideKeyboard(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _authBloc.add(LoginEvent(
      phone: phone,
      pin: _currentPin,
    ));
  }

  _inputPin() {
    AppUtil().hideKeyboard(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _userBloc.add(VerifyPinEvent(
      pin: _currentPin,
    ));
  }
}

class CheckPinArguments {
  final dynamic data;

  CheckPinArguments(this.data);
}
