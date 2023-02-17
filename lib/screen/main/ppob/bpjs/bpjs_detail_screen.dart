import 'package:alhikmah_app/screen/main/ppob/bpjs/bpjs_payment_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment.dart';
import 'package:alhikmah_app/util/app_style.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_textfield_number.dart';
import 'package:flutter/material.dart';

class BpjsDetailScreen extends StatefulWidget {
  const BpjsDetailScreen({Key key}) : super(key: key);

  @override
  _BpjsDetailScreenState createState() => _BpjsDetailScreenState();
}

class _BpjsDetailScreenState extends State<BpjsDetailScreen> {
  TextEditingController _noVa = TextEditingController();
  final _screen = ScreenUtil();
  BpjsDetailArguments args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    _noVa.text = args.data.no;
    return CustomAppBarDetail(
      title: 'BPJS',
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _screen.widthDefault(context) / 16),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: _screen.heightDefault(context) / 20),
                CustomText(text: 'No. VA Keluarga'),
                ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _noVa,
                    builder: (context, value, child) {
                      return CustomTextFieldNumber(
                        controller: _noVa,
                        isSuffix: false,
                        isReadOnly: true,
                      );
                    }),
                SizedBox(height: _screen.heightDefault(context) / 24),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Pelanggan',
                        style: descTextStyle,
                      ),
                      Text(
                        args.data.bpjsName,
                        style: titleHeadingTextStyle,
                      ),
                      SizedBox(height: _screen.heightDefault(context) / 40),
                      Text(
                        'Periode Bulanan',
                        style: descTextStyle,
                      ),
                      Text(
                        '${args.data.bpjsPeriod} Bulan',
                        style: titleHeadingTextStyle,
                      ),
                      SizedBox(height: _screen.heightDefault(context) / 40),
                      Text(
                        'Detail Pembayaran',
                        style: descTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tagihan',
                            style: titleHeadingTextStyle,
                          ),
                          Text(
                            AppUtil().formattedMoneyIDR(args.data.bill),
                            style: titleHeadingTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Admin',
                            style: titleHeadingTextStyle,
                          ),
                          Text(
                            AppUtil().formattedMoneyIDR(args.data.admin),
                            style: titleHeadingTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Tagihan',
                            style: titleHeadingTextStyle,
                          ),
                          Text(
                            AppUtil().formattedMoneyIDR(args.data.total),
                            style: titleHeadingTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                )
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
                        valueListenable: _noVa,
                        builder: (context, value, child) {
                          return CustomButtonRaised(
                            onTap: () {
                              var data = PaymentModel(
                                no: args.data.no,
                                name: args.data.bpjsName,
                                bill: args.data.bill,
                                admin: args.data.admin,
                                total: args.data.total,
                                bpjsNo: args.data.no,
                                bpjsName: args.data.bpjsName,
                                bpjsPeriod: args.data.bpjsPeriod,
                                  noTransaction: args.data.noTransaction);
                              MyNavigator.goToHomeBPJSPayment(
                                  context, BpjsPaymentArguments(data));
                            },
                            isCompleted: _noVa.text.isNotEmpty,
                            title: 'Lanjut',
                          );
                        }),
                    SizedBox(width: _screen.widthDefault(context) / 16),
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _noVa,
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

class BpjsDetailArguments {
  final PaymentModel data;

  BpjsDetailArguments(this.data);
}
