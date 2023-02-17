import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class CustomButtonOutline extends StatelessWidget {
  final Function onTap;
  final String title;

  CustomButtonOutline({Key key, this.onTap, this.title}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE)),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: _screen.widthDefault(context) / 50,
          vertical: _screen.heightDefault(context) / 70),
      onPressed: () async {
        await onTap();
      },
      child: Text(
        title,
        style: TextStyle(
            color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
            fontWeight: FontWeight.w800,
            fontSize: 16),
        textAlign: TextAlign.center,
      ),
      color: Colors.white,
      disabledColor: Colors.white,
    );
  }
}
