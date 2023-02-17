import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class CustomTextFieldCheck extends StatelessWidget {
  final TextEditingController controller;
  final bool isSuffix;

  CustomTextFieldCheck({Key key, this.controller, this.isSuffix})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.go,
      decoration: InputDecoration(
        suffix: isSuffix
            ? Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: AppUtil().parseHexColor(CustomColors.JUNGLE_GREEN),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: _screen.widthDefault(context) / 38,
                ),
              )
            : null,
        filled: true,
        isDense: true,
        fillColor: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: _screen.widthDefault(context) / 24,
            vertical: _screen.heightDefault(context) / 64),
      ),
    );
  }
}
