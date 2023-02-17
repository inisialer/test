import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class CustomButtonRaised extends StatelessWidget {
  final Function onTap;
  final String title;
  final bool isCompleted;
  double width;

  CustomButtonRaised({Key key, this.onTap, this.title, this.isCompleted, this.width = 100})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: _screen.widthDefault(context) / 50,
          vertical: _screen.heightDefault(context) / 70),
      onPressed: () async {
        isCompleted ? await onTap() : print('Not yet');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _screen.widthDefault(context) / 30),
        child: Container(
          width: width,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ),
      ),
      color: !isCompleted
          ? AppUtil().parseHexColor(CustomColors.NOBEL)
          : AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
      disabledColor: isCompleted
          ? AppUtil().parseHexColor(CustomColors.NOBEL)
          : AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
    );
  }
}
