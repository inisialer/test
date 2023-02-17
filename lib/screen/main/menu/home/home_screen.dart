import 'dart:async';

import 'package:after_init/after_init.dart';
import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/screen/main/menu/home/widget/notif_home.dart';
import 'package:alhikmah_app/service/tabungan/tabungan_list_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../bloc/registration_status/_bloc.dart';
import 'data/list_menu_home.dart';

part 'package:alhikmah_app/screen/main/menu/home/widget/header_home.dart';
part 'package:alhikmah_app/screen/main/menu/home/widget/menu_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _HeaderHome(),
        _MenuHome(),
        SizedBox(height: _screen.heightDefault(context) / 6.5)
      ],
    );
  }
}
