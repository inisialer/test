import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_confirm.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_final.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_status_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_zipay_screen.dart';
import 'package:alhikmah_app/util/app_style.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_container_rounded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PaymentConfirmScreen extends StatefulWidget {
  const PaymentConfirmScreen({Key key}) : super(key: key);

  @override
  _PaymentConfirmScreenState createState() => _PaymentConfirmScreenState();
}

class _PaymentConfirmScreenState extends State<PaymentConfirmScreen> {
  PaymentConfirmArguments args;
  final _screen = ScreenUtil();
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is GetBalanceSuccessState) {
          EasyLoading.dismiss();
          if (state.state == 'payment') {
            if (state.data.data.balance >= args.data.total) {
              var data = PaymentFinalModel(
                  noTransaction: args.data.noTransaction,
                  type: args.data.typeMenu,
                  fromMenu: 'home',
                  va: 'va');
              MyNavigator.goToHomePaymentZipay(
                  context, PaymentZipayArguments(data));
            } else {
              AppUtil.showToast("Saldo anda tidak mencukupi");
            }
          }
        } else if (state is GetBalanceFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Konfirmasi Pembayaran',
            body: Padding(
              padding: EdgeInsets.only(
                  top: _screen.heightDefault(context) / 100,
                  left: _screen.widthDefault(context) / 16,
                  right: _screen.widthDefault(context) / 16),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      SizedBox(height: _screen.heightDefault(context) / 100),
                      CustomContainerRounded(
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(args.data.menuDataNoOrName,
                                style: descTextStyle),
                            Text(args.data.noOrName, style: titleTextStyle),
                            SizedBox(
                                height: _screen.heightDefault(context) / 100),
                            Text(args.data.menuDataType, style: descTextStyle),
                            Text(args.data.type, style: titleTextStyle),
                            SizedBox(
                                height: _screen.heightDefault(context) / 100),
                            Text('No. Transaksi', style: descTextStyle),
                            Text(args.data.noTransaction,
                                style: titleTextStyle),
                            SizedBox(
                                height: _screen.heightDefault(context) / 100),
                            Text('Tanggal', style: descTextStyle),
                            Text(args.data.date, style: titleTextStyle),
                          ],
                        ),
                      ),
                      SizedBox(height: _screen.heightDefault(context) / 40),
                      CustomContainerRounded(
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Informasi Pembayaran', style: titleTextStyle),
                            SizedBox(
                                height: _screen.heightDefault(context) / 100),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tagihan', style: titleTextStyle),
                                Text(
                                    AppUtil().formattedMoneyIDR(args.data.bill),
                                    style: titleTextStyle),
                              ],
                            ),
                            SizedBox(
                                height: _screen.heightDefault(context) / 100),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Administrasi', style: titleTextStyle),
                                Text(
                                    AppUtil()
                                        .formattedMoneyIDR(args.data.admin),
                                    style: titleTextStyle),
                              ],
                            ),
                            SizedBox(
                                height: _screen.heightDefault(context) / 100),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Pembayaran', style: titleTextStyle),
                                Text(
                                    AppUtil()
                                        .formattedMoneyIDR(args.data.total),
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
                                (args.data.paymentMethod == 'ZIPAY')
                                    ? 'Zipay'
                                    : 'Transfer Bank (${args.data.bank.bankName})',
                                style: titleTextStyle,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: _screen.heightDefault(context) / 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButtonRaised(
                        onTap: () {
                          if (args.data.paymentMethod == 'ZIPAY') {
                            EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            _userBloc.add(BalanceEvent(state: 'payment'));
                          } else
                            MyNavigator.goToHomePaymentStatus(
                                context, PaymentStatusArguments(args.data));
                        },
                        isCompleted: true,
                        title: 'Bayar',
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PaymentConfirmArguments {
  final PaymentConfirmModel data;

  PaymentConfirmArguments(this.data);
}
