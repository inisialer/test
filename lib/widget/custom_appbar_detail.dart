import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:flutter/material.dart';

class CustomAppBarDetail extends StatelessWidget {
  final String title;
  final Widget body;
  final Color background;
  final bool isLeadingShow;
  final bool withDecoration;
  List<Widget> actions = [];

  CustomAppBarDetail(
      {Key key,
      this.title,
      this.body,
      this.background,
      this.isLeadingShow,
      this.actions,
      this.withDecoration = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppUtil().parseHexColor(CustomColors.PALE_GREEN),
            AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
          ],
        ),
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              centerTitle: true,
              actions: actions,
              title: Text(
                title,
                style: TextStyle(
                    color: AppUtil().parseHexColor(CustomColors.AMAZON),
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              backgroundColor:
                  background != null ? background : Colors.transparent,
              elevation: 0.0,
              leading: Visibility(
                visible: isLeadingShow ?? true,
                child: GestureDetector(
                    onTap: () {
                      MyNavigator.goClose(context);
                    },
                    child: Image.asset('assets/icon/ic_back.png')),
              )),
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: this.withDecoration
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ))
                : BoxDecoration(
                    color: Colors.white,
                  ),
            child: body,
          )),
    );
  }
}
