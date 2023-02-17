import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class CustomButtonUploadImage extends StatelessWidget {
  final String title;
  final String desc;
  final bool isSuccess;

  CustomButtonUploadImage({Key key, this.title, this.desc, this.isSuccess})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        border: Border.all(
            color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
            width: 5),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: _screen.widthDefault(context) / 16,
          vertical: _screen.heightDefault(context) / 64),
      child: Row(
        children: [
          Image.asset('assets/icon/ic_camera_upload.png'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _screen.widthDefault(context) / 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: AppUtil()
                            .parseHexColor(CustomColors.GRANNY_SMITH_APPLE)),
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color:
                            AppUtil().parseHexColor(CustomColors.SHADY_LADY)),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            isSuccess
                ? 'assets/icon/ic_transaction_success.png'
                : 'assets/icon/ic_transaction_failed.png',
            height: _screen.heightDefault(context) / 20,
            width: _screen.heightDefault(context) / 20,
          ),
        ],
      ),
    );
  }
}
