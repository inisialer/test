import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class ListHistoryTransaction extends StatelessWidget {
  String transactionDate;
  bool withDate;
  String description;
  String time;
  String amount;
  String status;

  ListHistoryTransaction(
      {Key key,
      this.transactionDate,
      this.withDate,
      this.description,
      this.amount,
        this.status,
      this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(this.withDate)
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(this.transactionDate, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
          ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300],
                width: 1,
              )
            )
          ),
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.only(bottom: 10),
          width: ScreenUtil().widthDefault(context),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset("assets/image/logo_zipay.png"),
                  Text(this.amount, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),),
                ],
              ),
             Container(
               margin: EdgeInsets.only(top: 10),
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Expanded(child: Text("${this.description} (${this.status})")),
                   Container(
                     margin: EdgeInsets.only(left: 20),
                     child: Text(this.time, style: TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 15,
                     ),
                   ),),
                 ],
               ),
             )
            ],
          ),
        )
      ],
    );
  }
}
