import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';

import 'data/item_list_notification.dart';
import 'detail_notification_screen.dart';

part 'package:alhikmah_app/screen/main/menu/notification/widget/item_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isVisibleDelete = false;
  bool _isDeleteAll = false;
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtil().parseHexColor(CustomColors.ALICE_BLUE),
      appBar: AppBar(
        title: Text(
          'Pemberitahuan',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppUtil().parseHexColor(CustomColors.AMAZON)),
        ),
        backgroundColor: AppUtil().parseHexColor(CustomColors.ALICE_BLUE),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_screen.heightDefault(context) / 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isVisibleDelete = !_isVisibleDelete;
                      });
                    },
                    child: Visibility(
                      visible: itemListNotification.isNotEmpty,
                      child: Padding(
                          padding: EdgeInsets.only(
                              right: _screen.widthDefault(context) / 40),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: _screen.widthDefault(context) / 24),
                            padding: EdgeInsets.only(
                                left: _screen.widthDefault(context) / 40,
                                right: _screen.widthDefault(context) / 24,
                                top: _screen.heightDefault(context) / 120,
                                bottom: _screen.heightDefault(context) / 120),
                            decoration: BoxDecoration(
                                color: (_isVisibleDelete &&
                                    itemListNotification.isNotEmpty)
                                    ? AppUtil().parseHexColor(
                                    CustomColors.GRANNY_SMITH_APPLE)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(70),
                                border: Border.all(
                                    color: AppUtil().parseHexColor(
                                        CustomColors.GRANNY_SMITH_APPLE))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.delete,
                                    color: (_isVisibleDelete &&
                                        itemListNotification.isNotEmpty)
                                        ? Colors.white
                                        : AppUtil().parseHexColor(
                                        CustomColors.GRANNY_SMITH_APPLE)),
                                SizedBox(
                                    width: _screen.widthDefault(context) / 60),
                                Text(
                                  'Hapus',
                                  style: TextStyle(
                                      color: (_isVisibleDelete &&
                                          itemListNotification.isNotEmpty)
                                          ? Colors.white
                                          : AppUtil().parseHexColor(
                                          CustomColors.GRANNY_SMITH_APPLE),
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                          )),
                    ),
                  )),
              Visibility(
                visible: _isVisibleDelete && itemListNotification.isNotEmpty,
                child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDeleteAll = !_isDeleteAll;
                          itemListNotification.forEach((element) {
                            _isDeleteAll
                                ? element.isChecked = true
                                : element.isChecked = false;
                          });
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              right: _screen.widthDefault(context) / 24),
                          child: Text(
                            'Semua',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _isDeleteAll
                                    ? AppUtil().parseHexColor(
                                        CustomColors.GRANNY_SMITH_APPLE)
                                    : AppUtil()
                                        .parseHexColor(CustomColors.MORTAR)),
                          )),
                    )),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(height: _screen.heightDefault(context) / 100),
          Padding(
            padding:
                EdgeInsets.only(bottom: _screen.heightDefault(context) / 6.5),
            child: ListView(
              children: [
                SizedBox(height: _screen.heightDefault(context) / 100),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _ItemNotification(
                      item: itemListNotification[index],
                      isVisible: _isVisibleDelete,
                    );
                  },
                  itemCount: itemListNotification.length,
                ),
              ],
            ),
          ),
          Visibility(
              visible: itemListNotification.isEmpty,
              child: Center(
                child: Text(
                  'Belum Ada Pemberitahuan',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppUtil().parseHexColor(CustomColors.NOBEL),
                      fontWeight: FontWeight.w600),
                ),
              )),
          Visibility(
            visible: _isVisibleDelete && itemListNotification.isNotEmpty,
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: _screen.heightDefault(context) / 6),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButtonRaised(
                    title: 'Hapus',
                    isCompleted: true,
                    onTap: () {
                      setState(() {
                        itemListNotification
                            .removeWhere((i) => i.isChecked == true);
                      });
                    },
                  )),
            ),
          )
        ],
      ),
    );
  }
}
