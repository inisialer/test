import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:flutter/material.dart';

class ZakatScreen extends StatefulWidget {
  const ZakatScreen({Key key}) : super(key: key);

  @override
  _ZakatScreenState createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
      title: 'Zakat',
      body: ListView(
        children: [],
      ),
    );
  }
}
