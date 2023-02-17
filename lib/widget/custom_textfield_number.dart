import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldNumber extends StatelessWidget {
  final TextEditingController controller;
  final bool isReadOnly;
  final bool isSuffix;
  final bool isNumber;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Color color;

  CustomTextFieldNumber(
      {Key key,
      this.controller,
      this.isReadOnly,
      this.isSuffix,
      this.isNumber = true,
      this.textInputAction,
      this.keyboardType,
      this.color})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly ?? false,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters: isNumber
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      textInputAction: textInputAction ?? TextInputAction.go,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: color ?? AppUtil().parseHexColor(CustomColors.NOBEL)),
      decoration: InputDecoration(
        suffix: (isSuffix ?? true) && controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  controller.clear();
                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: AppUtil().parseHexColor(CustomColors.SHADY_LADY),
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: _screen.widthDefault(context) / 38,
                  ),
                ))
            : null,
        filled: true,
        isDense: true,
        fillColor: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(48),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(48),
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
