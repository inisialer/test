import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdown extends StatelessWidget {
  final String item;
  final List<String> items;
  final String category;
  final String hint;
  final Color color;

  CustomDropdown(
      {Key key, this.item, this.items, this.category, this.hint, this.color})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    UtilBloc _utilBloc;
    _utilBloc = BlocProvider.of<UtilBloc>(context);
    return Container(
      decoration: BoxDecoration(
          color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
          borderRadius: BorderRadius.circular(48)),
      padding: EdgeInsets.symmetric(
          horizontal: _screen.widthDefault(context) / 24,
          vertical: _screen.heightDefault(context) / 100),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
            ),
            hint: Text(hint,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppUtil().parseHexColor(CustomColors.NOBEL))),
            value: item,
            isExpanded: true,
            isDense: true,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color ?? AppUtil().parseHexColor(CustomColors.NOBEL)),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              _utilBloc.add(SetDropdownEvent(item: value, category: category));
            }),
      ),
    );
  }
}

class CustomDropdownX extends StatelessWidget {
  final String item;
  final List<DropdownMenuItem<String>> items;
  final String itemShow;
  final String category;
  final String hint;
  final Color color;
  final Function onChanged;

  CustomDropdownX(
      {Key key,
      this.item,
      this.items,
      this.category,
      this.hint,
      this.color,
      this.itemShow,
      this.onChanged})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    return Container(
      decoration: BoxDecoration(
          color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
          borderRadius: BorderRadius.circular(48)),
      padding: EdgeInsets.symmetric(
          horizontal: _screen.widthDefault(context) / 24,
          vertical: _screen.heightDefault(context) / 100),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
            ),
            hint: Text(hint,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppUtil().parseHexColor(CustomColors.NOBEL))),
            value: item,
            isExpanded: true,
            isDense: true,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color ?? AppUtil().parseHexColor(CustomColors.NOBEL)),
            items: items,
            onChanged: onChanged),
      ),
    );
  }
}
