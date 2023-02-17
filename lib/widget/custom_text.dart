import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final _screen = ScreenUtil();

  CustomText({Key key, this.text, this.fontSize, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: _screen.widthDefault(context) / 40,
          bottom: _screen.heightDefault(context) / 120),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: fontSize ?? 16,
            color: color ?? AppUtil().parseHexColor(CustomColors.MORTAR)),
      ),
    );
  }
}
