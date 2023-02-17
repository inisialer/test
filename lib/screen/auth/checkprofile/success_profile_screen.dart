import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class SuccessProfileScreen extends StatefulWidget {
  const SuccessProfileScreen({Key key}) : super(key: key);

  @override
  _SuccessProfileScreenState createState() => _SuccessProfileScreenState();
}

class _SuccessProfileScreenState extends State<SuccessProfileScreen> {
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => MyNavigator.goToMain(context),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: _screen.heightDefault(context) / 20),
                Image.asset(Images.LOGO_ALHIKMAH),
                SizedBox(height: _screen.heightDefault(context) / 8),
                Image.asset(
                  'assets/icon/ic_transaction_success.png',
                  height: _screen.heightDefault(context) / 8,
                ),
                SizedBox(height: _screen.heightDefault(context) / 50),
                Text(
                  'Alhamdulillah\nPendaftaran Berhasil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: _screen.heightDefault(context) / 30),
                child: Text(
                  'Ketuk Untuk Melanjutkan',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
