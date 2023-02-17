import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:flutter/material.dart';

import 'data/item_list_notification.dart';

class DetailNotificationScreen extends StatelessWidget {
  DetailNotificationScreen({Key key}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    DetailNotificationArguments args =
        ModalRoute.of(context).settings.arguments;

    return CustomAppBarDetail(
      title: 'Pemberitahuan',
      body: Padding(
        padding: EdgeInsets.only(
            top: _screen.heightDefault(context) / 100,
            left: _screen.widthDefault(context) / 16,
            right: _screen.widthDefault(context) / 16),
        child: ListView(
          children: [
            SizedBox(height: _screen.heightDefault(context) / 100),
            Container(
              height: _screen.heightDefault(context) / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: AssetImage(Images.EXAMPLE), fit: BoxFit.cover)),
            ),
            SizedBox(height: _screen.heightDefault(context) / 24),
            Text(
              args.data.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            Text(
              args.data.desc,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
          ],
        ),
      ),
    );
  }
}

class DetailNotificationArguments {
  final ItemNotificationModel data;

  DetailNotificationArguments(this.data);
}
