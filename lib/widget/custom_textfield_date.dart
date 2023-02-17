import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldDate extends StatelessWidget {
  final TextEditingController controller;
  final int maxLenght;

  const CustomTextFieldDate({Key key, this.controller, this.maxLenght})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
      ),
      margin: const EdgeInsets.only(right: 16),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLenght),
        ],
        cursorColor: Theme.of(context).primaryColor,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: '${('0') * maxLenght}',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ),
      ),
    );
  }
}
