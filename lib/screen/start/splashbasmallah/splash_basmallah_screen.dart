import 'dart:async';

import 'package:alhikmah_app/bloc/auth/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/permission_handler.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';

class SplashBasmallahScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashBasmallahScreenState();
  }
}

class _SplashBasmallahScreenState extends State<SplashBasmallahScreen> {
  final _screen = ScreenUtil();
  AuthBloc _authBloc;
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _checkPermission();
    _navigationPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RefreshTokenSuccessState) {
          _prefs.setString(
              SharePrefs.ACCESS_TOKEN, state.data.data.accessToken);
          _prefs.setString(
              SharePrefs.REFRESH_TOKEN, state.data.data.refreshToken);
          _prefs.setInt(SharePrefs.EXPIRES_TOKEN, state.data.data.expiresAt);
          MyNavigator.goToSplash(context);
        } else if (state is RefreshTokenFailedState) {
          _prefs.setString(SharePrefs.NAME, '');
          _prefs.setString(SharePrefs.ACCESS_TOKEN, '');
          _prefs.setString(SharePrefs.REFRESH_TOKEN, '');
          _prefs.setInt(SharePrefs.EXPIRES_TOKEN, 0);
          MyNavigator.goToSplash(context);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: _screen.heightDefault(context),
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.BACKGROUND_SPLASH),
                      fit: BoxFit.cover)),
              padding:
                  EdgeInsets.only(top: _screen.heightDefault(context) / 20),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: _screen.heightDefault(context) / 25),
                        child: Image.asset(Images.LOGO_ALHIKMAH),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: _screen.heightDefault(context) / 30),
                      child: Container(
                          height: _screen.heightDefault(context) / 40,
                          width: _screen.widthDefault(context) / 24,
                          child: CircularProgressIndicator(
                            backgroundColor: AppUtil()
                                .parseHexColor(CustomColors.WHITE_SMOKE),
                          )),
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding:
                        EdgeInsets.all(_screen.heightDefault(context) / 25),
                    child: Image.asset(Images.BISMILLAH),
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _checkPermission() async {
    PermissionHandlerService permissionHandlerService =
        PermissionHandlerService();
    permissionHandlerService.checkPermission();
  }

  _navigationPage() {
    Timer(
      Duration(seconds: 2),
      () {
        if ((_prefs.getInt(SharePrefs.EXPIRES_TOKEN) != null) &&
            (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) != 0)) {
          if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
              DateTime.now().millisecondsSinceEpoch) {
            _authBloc.add(RefreshTokenEvent(
                refreshToken: _prefs.getString(SharePrefs.REFRESH_TOKEN)));
          } else {
            MyNavigator.goToSplash(context);
          }
        } else {
          MyNavigator.goToSplash(context);
        }
      },
    );
  }
}
