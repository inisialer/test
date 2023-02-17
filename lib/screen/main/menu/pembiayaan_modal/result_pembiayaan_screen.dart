import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:flutter/material.dart';

class ResultPembiyaanScreen extends StatefulWidget {
  @override
  State<ResultPembiyaanScreen> createState() => _ResultPembiyaanScreenState();
}

class _ResultPembiyaanScreenState extends State<ResultPembiyaanScreen> {
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
        title: "Pembiayaan",
        isLeadingShow: true,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icon/ic_transaction_success.png',
                    height: _screen.heightDefault(context) / 8,
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 50),
                  Text(
                    'Alhamdulillah Anda Telah Berhasil Melakukan Pengajuan Pembiayaan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                  Text(
                    'Silahkan Tunggu Notifikasi Untuk Melihat Status Pengajuan Pembiayaan Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/main');
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: _screen.heightDefault(context) / 30),
                  child: Text(
                    'Ketuk Untuk Melanjutkan',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
