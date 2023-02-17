import 'dart:developer';

import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CustomTextFieldForm extends StatelessWidget {
  final _screen = ScreenUtil();

  final TextEditingController controller;
  final MoneyMaskedTextController controllerMaskMoney;
  final String hintText;
  final String prefixText;
  final Function validator;
  final Function onSaved;
  final bool isReadOnly;
  final bool isNumber;
  final bool isAll;
  final bool isObscure;
  final int maxLength;
  final Color color;
  final List<TextInputFormatter> formatter;
  final TextInputType keyboardType;
  final FilteringTextInputFormatter filteringTextInputFormatter;

  CustomTextFieldForm(
      {this.hintText,
      this.validator,
      this.prefixText,
      this.onSaved,
      this.isReadOnly,
      this.formatter,
      this.isNumber = false,
      this.keyboardType,
      this.controller,
      this.isObscure,
      this.filteringTextInputFormatter,
      this.controllerMaskMoney,
      this.maxLength,
      this.isAll = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: !isAll
          ? [
              isNumber == false
                  ? FilteringTextInputFormatter.allow(RegExp('[aA0-zZ9 ]'))
                  : FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ]
          : formatter,
      onChanged: (value) {
        var val = value.replaceAll(RegExp(r'Rp '), '');
        value = val.replaceAll('.', '');
        log(value);
      },
      maxLength: maxLength ?? null,
      controller: controllerMaskMoney ?? controller ?? null,
      readOnly: isReadOnly ?? false,
      obscureText: isObscure ?? false,
      textInputAction: TextInputAction.go,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: color ?? AppUtil().parseHexColor(CustomColors.NOBEL)),
      decoration: InputDecoration(
        hintText: hintText ?? '',
        prefixText: prefixText ?? '',
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(48),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
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
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }
}
