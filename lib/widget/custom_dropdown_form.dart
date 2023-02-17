import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdownForm extends StatelessWidget {
  final String itemValue;
  final List<dynamic> itemData;
  final String idKey;
  final String nameKey;
  final String category;
  final String hint;
  final Color color;
  final Function validator;
  final Function onSaved;

  CustomDropdownForm(
      {Key key,
      this.category,
      this.hint,
      this.color,
      this.itemValue,
      this.itemData,
      this.idKey,
      this.nameKey,
      this.validator,
      this.onSaved})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    UtilBloc _utilBloc = BlocProvider.of<UtilBloc>(context);
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          isDense: true,
          hintStyle: TextStyle(
              fontSize: 14,
              color: AppUtil().parseHexColor(CustomColors.GAINSBORO)),
          contentPadding: EdgeInsets.symmetric(
              horizontal: _screen.widthDefault(context) / 24,
              vertical: _screen.heightDefault(context) / 100),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(48),
          ),
          filled: true,
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
        ),
        validator: validator,
        onSaved: onSaved,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
        ),
        hint: Text(hint,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppUtil().parseHexColor(CustomColors.NOBEL))),
        value: itemValue,
        isExpanded: true,
        isDense: true,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: color ?? AppUtil().parseHexColor(CustomColors.NOBEL)),
        items: itemData.map((item) {
          return DropdownMenuItem<String>(
            child: Text(
              item[nameKey] ?? item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            value: item[idKey].toString() ?? item,
          );
        }).toList(),
        onChanged: itemData.isEmpty
            ? null
            : (value) {
                _utilBloc
                    .add(SetDropdownEvent(item: value, category: category));
              });
  }
}
