import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class ListFeature extends StatelessWidget {
  String name;
  String asset;
  String description;

  ListFeature({Key key, this.name, this.asset, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().heightDefault(context)/20),
      width: ScreenUtil().widthDefault(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(this.asset, height: 50, fit: BoxFit.fitWidth,),
          Container(
            width: 20,
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              Text(this.description, style: TextStyle(
                fontSize: 15
              ),)
            ],
          ))
        ],
      ),
    );
  }
}
