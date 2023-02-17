import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_confirm.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_final.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_bank_screen.dart';
import 'package:alhikmah_app/util/app_style.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_container_rounded.dart';
import 'package:alhikmah_app/widget/custom_container_status.dart';
import 'package:flutter/material.dart';

part 'package:alhikmah_app/screen/main/ppob/payment/widget/item_data_status.dart';

class PaymentStatusScreen extends StatefulWidget {
  const PaymentStatusScreen({Key key}) : super(key: key);

  @override
  _PaymentStatusScreenState createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  PaymentStatusArguments args;

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return CustomAppBarDetail(
      title: 'Status Pembayaran',
      body: Padding(
        padding: EdgeInsets.only(
            top: _screen.heightDefault(context) / 100,
            left: _screen.widthDefault(context) / 16,
            right: _screen.widthDefault(context) / 16),
        child: ListView(
          children: [
            SizedBox(height: _screen.heightDefault(context) / 100),
            CustomContainerStatus(
              status: 'waiting-payment',
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomContainerRounded(
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ItemDataStatus(
                      data: args.data.pdamCity ?? '', title: 'Kota'),
                  _ItemDataStatus(
                      data: args.data.pdamNo ?? '', title: 'No. Pelanggan'),
                  _ItemDataStatus(
                      data: args.data.pdamName ?? '', title: 'Nama Pelanggan'),
                  _ItemDataStatus(
                      data: args.data.pdamPeriod ?? '',
                      title: 'Periode Tagihan'),
                  _ItemDataStatus(
                      data: args.data.bpjsNo ?? '', title: 'No. VA Keluarga'),
                  _ItemDataStatus(
                      data: args.data.bpjsName ?? '', title: 'Nama Pelanggan'),
                  _ItemDataStatus(
                      data: args.data.plnNo ?? '', title: 'No. Meter ID'),
                  _ItemDataStatus(
                      data: args.data.pascabayarOperator ?? '',
                      title: 'Provider'),
                  _ItemDataStatus(
                      data: args.data.pascabayarNo ?? '', title: 'No. Telepon'),
                  _ItemDataStatus(
                      data: args.data.pascabayarName ?? '',
                      title: 'Nama Pelanggan'),
                  _ItemDataStatus(
                      data: (args.data.pulsaNo != null)
                          ? AppUtil().formattedMoneyIDR(args.data.bill)
                          : '' ?? '',
                      title: args.data.pulsaType ?? ''),
                  _ItemDataStatus(
                      data: args.data.pulsaNo ?? '', title: 'No. Telepon'),
                  _ItemDataStatus(
                      data: args.data.noTransaction ?? '',
                      title: 'No. Transaksi'),
                  _ItemDataStatus(data: args.data.date ?? '', title: 'Tanggal'),
                ],
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomContainerRounded(
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Informasi Pembayaran', style: titleTextStyle),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tagihan', style: titleTextStyle),
                      Text(AppUtil().formattedMoneyIDR(args.data.bill),
                          style: titleTextStyle),
                    ],
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Administrasi', style: titleTextStyle),
                      Text(AppUtil().formattedMoneyIDR(args.data.admin),
                          style: titleTextStyle),
                    ],
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Pembayaran', style: titleTextStyle),
                      Text(AppUtil().formattedMoneyIDR(args.data.total),
                          style: titleTextStyle),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomContainerRounded(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Metode Pembayaran', style: titleTextStyle),
                  SizedBox(
                    width: _screen.widthDefault(context) / 24,
                  ),
                  Expanded(
                    child: Text(
                      'Transfer Bank (${args.data.bank.bankName})',
                      style: titleTextStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            Column(
              children: [
                CustomButtonRaised(
                  onTap: () {
                    var data = PaymentFinalModel(
                        noTransaction: args.data.noTransaction,
                        type: args.data.typeMenu,
                        bank: args.data.bank,
                        fromMenu: 'home',
                        va: '');
                    MyNavigator.goToHomePaymentBank(
                        context, PaymentBankArguments(data));
                  },
                  isCompleted: true,
                  title: 'Bayar Sekarang',
                ),
              ],
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
          ],
        ),
      ),
    );
  }
}

class PaymentStatusArguments {
  final PaymentConfirmModel data;

  PaymentStatusArguments(this.data);
}
