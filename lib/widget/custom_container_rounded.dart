import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class CustomContainerRounded extends StatelessWidget {
  final Widget widget;
  final double paddingVertical;
  final double paddingHorizontal;

  CustomContainerRounded(
      {Key key, this.widget, this.paddingVertical, this.paddingHorizontal})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? _screen.heightDefault(context) / 40,
          horizontal: paddingHorizontal ?? _screen.widthDefault(context) / 20),
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: widget,
    );
  }
}
