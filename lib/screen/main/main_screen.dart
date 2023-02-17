import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/auth/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/screen/main/menu/home/home_screen.dart';
import 'package:alhikmah_app/screen/main/menu/notification/notification_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/profile_screen.dart';
import 'package:alhikmah_app/screen/main/menu/transaction/transaction_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _screen = ScreenUtil();
  int _index = 0;
  final List<Widget> menu = <Widget>[
    HomeScreen(),
    TransactionScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  SharedPreferences _prefs = App().sharedPreferences;

  @override
  void initState() {
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
        } else if (state is RefreshTokenFailedState) {
          _prefs.setString(SharePrefs.NAME, '');
          _prefs.setString(SharePrefs.ACCESS_TOKEN, '');
          _prefs.setString(SharePrefs.REFRESH_TOKEN, '');
          _prefs.setInt(SharePrefs.EXPIRES_TOKEN, 0);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppUtil().parseHexColor(CustomColors.ALICE_BLUE),
            body: Stack(
              children: [
                menu.elementAt(_index),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 2), // changes position of shadow
                          )
                        ]),
                    margin: EdgeInsets.only(
                        bottom: _screen.heightDefault(context) / 32,
                        left: _screen.widthDefault(context) / 20,
                        right: _screen.widthDefault(context) / 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => setState(() => _index = 0),
                            child: Container(
                                margin: EdgeInsets.all(
                                    _screen.widthDefault(context) / 50),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: (_index == 0)
                                          ? [
                                              AppUtil().parseHexColor(
                                                  CustomColors.PALE_GREEN),
                                              AppUtil().parseHexColor(
                                                  CustomColors
                                                      .GRANNY_SMITH_APPLE),
                                            ]
                                          : [
                                              Colors.white,
                                              Colors.white,
                                            ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          _screen.heightDefault(context) / 125,
                                      horizontal:
                                          _screen.widthDefault(context) / 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.home,
                                        size:
                                            _screen.heightDefault(context) / 16,
                                        color: (_index == 0)
                                            ? Colors.white
                                            : AppUtil().parseHexColor(
                                                CustomColors
                                                    .GRANNY_SMITH_APPLE),
                                      ),
                                      Text(
                                        'Beranda',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (_index == 0)
                                                ? Colors.white
                                                : AppUtil().parseHexColor(
                                                    CustomColors
                                                        .GRANNY_SMITH_APPLE),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => setState(() => _index = 1),
                            child: Container(
                                margin: EdgeInsets.all(
                                    _screen.widthDefault(context) / 50),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: (_index == 1)
                                          ? [
                                              AppUtil().parseHexColor(
                                                  CustomColors.PALE_GREEN),
                                              AppUtil().parseHexColor(
                                                  CustomColors
                                                      .GRANNY_SMITH_APPLE),
                                            ]
                                          : [
                                              Colors.white,
                                              Colors.white,
                                            ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          _screen.heightDefault(context) / 125,
                                      horizontal:
                                          _screen.widthDefault(context) / 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.sync_alt_rounded,
                                          size: _screen.heightDefault(context) /
                                              16,
                                          color: (_index == 1)
                                              ? Colors.white
                                              : AppUtil().parseHexColor(
                                                  CustomColors
                                                      .GRANNY_SMITH_APPLE)),
                                      Text(
                                        'Transaksi',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (_index == 1)
                                                ? Colors.white
                                                : AppUtil().parseHexColor(
                                                    CustomColors
                                                        .GRANNY_SMITH_APPLE),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => setState(() => _index = 2),
                            child: Container(
                                margin: EdgeInsets.all(
                                    _screen.widthDefault(context) / 50),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: (_index == 2)
                                          ? [
                                              AppUtil().parseHexColor(
                                                  CustomColors.PALE_GREEN),
                                              AppUtil().parseHexColor(
                                                  CustomColors
                                                      .GRANNY_SMITH_APPLE),
                                            ]
                                          : [
                                              Colors.white,
                                              Colors.white,
                                            ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          _screen.heightDefault(context) / 125,
                                      horizontal:
                                          _screen.widthDefault(context) / 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.notifications,
                                          size: _screen.heightDefault(context) /
                                              16,
                                          color: (_index == 2)
                                              ? Colors.white
                                              : AppUtil().parseHexColor(
                                                  CustomColors
                                                      .GRANNY_SMITH_APPLE)),
                                      Text(
                                        'Notifikasi',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (_index == 2)
                                                ? Colors.white
                                                : AppUtil().parseHexColor(
                                                    CustomColors
                                                        .GRANNY_SMITH_APPLE),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => setState(() => _index = 3),
                            child: Container(
                                margin: EdgeInsets.all(
                                    _screen.widthDefault(context) / 50),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: (_index == 3)
                                          ? [
                                              AppUtil().parseHexColor(
                                                  CustomColors.PALE_GREEN),
                                              AppUtil().parseHexColor(
                                                  CustomColors
                                                      .GRANNY_SMITH_APPLE),
                                            ]
                                          : [
                                              Colors.white,
                                              Colors.white,
                                            ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          _screen.heightDefault(context) / 125,
                                      horizontal:
                                          _screen.widthDefault(context) / 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.person,
                                          size: _screen.heightDefault(context) /
                                              16,
                                          color: (_index == 3)
                                              ? Colors.white
                                              : AppUtil().parseHexColor(
                                                  CustomColors
                                                      .GRANNY_SMITH_APPLE)),
                                      Text(
                                        'Profil',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (_index == 3)
                                                ? Colors.white
                                                : AppUtil().parseHexColor(
                                                    CustomColors
                                                        .GRANNY_SMITH_APPLE),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
