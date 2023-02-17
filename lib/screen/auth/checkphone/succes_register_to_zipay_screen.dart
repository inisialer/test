import 'package:alhikmah_app/screen/auth/checkpin/check_pin_screen.dart';
import 'package:alhikmah_app/screen/auth/checkprofile/check_profile_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';

class SuccessRegisterToZipayScreen extends StatelessWidget {
  SuccessRegisterToZipayScreen({Key key}) : super(key: key);

  ScreenUtil _screen = ScreenUtil();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: _screen.widthDefault(context),
        height: _screen.heightDefault(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: _screen.heightDefault(context) * 0.2),
              child: Text(
                "Sambungkan Akun Zipay",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 20,
                children: [
                  Image.asset("assets/image/img_alhikmah.png"),
                  Image.asset("assets/icon/array_two_way.png"),
                  Image.asset("assets/image/img_bank_zipay.png")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: _screen.widthDefault(context) * 0.8,
              child: Text(
                "Berhasil Disambungkan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: _screen.widthDefault(context) * 0.8,
              child: Text(
                "Kini anda dapat melakukan pembayaran transaksi menggunakan Zipay pada aplikasi Al Hikmah",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: _screen.widthDefault(context) * 0.7,
                  margin: EdgeInsets.only(
                      bottom: _screen.heightDefault(context) * 0.1),
                  child: CustomButtonRaised(
                    isCompleted: true,
                    width: _screen.widthDefault(context) * 0.7,
                    onTap: () {
                      MyNavigator.goToSuccessProfile(context);
                    },
                    title: "Lanjutkan",
                  ),
                ),
                Text(
                  "Zipay telah resmi tercatat di OJK sebagai penyelenggara uang elektronik dengan Nomor : S-101/MS.72/2019",
                  textAlign: TextAlign.center,
                )
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
