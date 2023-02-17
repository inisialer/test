import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_final.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_zipay_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_textfield_number.dart';
import 'package:flutter/material.dart';

class TopUpWalletScreen extends StatefulWidget {
  const TopUpWalletScreen({Key key}) : super(key: key);

  @override
  _TopUpWalletScreenState createState() => _TopUpWalletScreenState();
}

class _TopUpWalletScreenState extends State<TopUpWalletScreen> {
  TextEditingController _noNominal = TextEditingController();
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
      title: 'Top Up',
      body: Padding(
        padding: EdgeInsets.only(
            left: _screen.widthDefault(context) / 16,
            right: _screen.widthDefault(context) / 16,
            top: _screen.heightDefault(context) / 20),
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                      top: _screen.heightDefault(context) / 100),
                  padding: EdgeInsets.all(_screen.widthDefault(context) / 40),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/image/img_bank_zipay.png',
                            width: _screen.widthDefault(context) / 5,
                            height: _screen.heightDefault(context) / 18,
                          ),
                          Text(
                            'Zipay',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppUtil()
                                    .parseHexColor(CustomColors.MORTAR)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 40),
                CustomText(text: 'Masukan Nominal Top Up'),
                ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _noNominal,
                    builder: (context, value, child) {
                      return CustomTextFieldNumber(controller: _noNominal);
                    }),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: _screen.heightDefault(context) / 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _noNominal,
                        builder: (context, value, child) {
                          return CustomButtonRaised(
                            onTap: () {
                              var data = PaymentFinalModel(
                                  noTransaction: '',
                                  type: 'topup',
                                  fromMenu: 'home',
                                  va: '');
                              MyNavigator.goToHomePaymentZipay(
                                  context, PaymentZipayArguments(data));
                            },
                            isCompleted: _noNominal.text.isNotEmpty,
                            title: 'Bayar',
                          );
                        }),
                    SizedBox(width: _screen.widthDefault(context) / 16),
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _noNominal,
                        builder: (context, value, child) {
                          return CustomButtonOutline(
                            onTap: () {
                              MyNavigator.goClose(context);
                            },
                            title: 'Batal',
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
