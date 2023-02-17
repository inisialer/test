import 'package:flutter/material.dart';

class CardZipay extends StatelessWidget {
  String name;
  String money;

  CardZipay({Key key, this.name, this.money}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      constraints: BoxConstraints(
        minHeight: 50,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            offset: const Offset(
              1.0,
              1.0,
            ),
            blurRadius: 2.0,
            spreadRadius: 4.0,
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/image/bg_zipay.png",
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/image/logo_zipay.png",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Saldo Kamu",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Text(
                this.name,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              money,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          )
        ],
      ),
    );
  }
}
