import 'dart:async';

import 'package:after_init/after_init.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/screen/auth/checkpin/check_pin_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with AfterInitMixin<SplashScreen> {
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.BACKGROUND_SPLASH),
                fit: BoxFit.cover)),
        child: Center(child: Image.asset(Images.LOGO_ALHIKMAH_LARGE)),
      ),
    );
  }

  @override
  void didInitState() {
    AppUtil().hideKeyboard(context);
    _navigationPage();
  }

  _navigationPage() {
    Timer(
      Duration(seconds: 2),
      () {
        if (_prefs.getBool(SharePrefs.IS_FIRST) == true ||
            _prefs.getBool(SharePrefs.IS_FIRST) == null) {
          MyNavigator.goToOnboarding(context);
          _prefs.setBool(SharePrefs.IS_FIRST, false);
        } else {
          if ((_prefs.getString(SharePrefs.ACCESS_TOKEN) == null) ||
              (_prefs.getString(SharePrefs.ACCESS_TOKEN) == '')) {
            MyNavigator.goToCheckPhone(context);
          } else if ((_prefs.getString(SharePrefs.ACCESS_TOKEN) != null) ||
              (_prefs.getString(SharePrefs.ACCESS_TOKEN) != '')) {
            var data = {
              'isSetPin': true,
              'phone': '',
              'isLogin': (_prefs.getBool(SharePrefs.IS_LOGIN) == null ||
                      _prefs.getBool(SharePrefs.IS_LOGIN) == false)
                  ? false
                  : true
            };
            MyNavigator.goToCheckPin(context, CheckPinArguments(data));
          }
        }
      },
    );
  }
}
