import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/payment/history_detail_biller_model.dart';
import 'package:alhikmah_app/model/payment/history_transaction_model.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_final.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_bank_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_zipay_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_container_rounded.dart';
import 'package:alhikmah_app/widget/custom_container_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/user/user_bloc.dart';
import '../../../../bloc/user/user_event.dart';

class DetailTransactionBillerScreen extends StatefulWidget {
  DetailTransactionBillerArguments args;

  DetailTransactionBillerScreen({Key key, this.args}) : super(key: key);

  @override
  _DetailTransactionBillerScreenState createState() =>
      _DetailTransactionBillerScreenState();
}

class _DetailTransactionBillerScreenState
    extends State<DetailTransactionBillerScreen> {
  final _screen = ScreenUtil();
  UserBloc _userBloc;
  HistoryDetailBillerModel _dataHistory;

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(MeEvent());
    super.initState();
  }

  var waiting = [
    "waiting",
    "waiting-confirmation",
    "waiting-paid",
    "waiting-payment"
  ];
  var success = ["success", "done", "success", "closed"];

  @override
  Widget build(BuildContext context) {
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
                status: widget.args.data.status.toLowerCase()),
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomContainerRounded(
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Atas Nama',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                  ),
                  BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                    if (state is GetMeSuccessState) {
                      return Text(
                        '${state.data.data.firstName} ${state.data.data.lastName}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color:
                                AppUtil().parseHexColor(CustomColors.MORTAR)),
                      );
                    }
                    return Text('');
                  }),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  Text(
                    'Pembayaran',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                  ),
                  Text(
                    widget.args.data.transactionDesc1 ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  Text(
                    'No. Transaksi',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                  ),
                  Text(
                    widget.args.data.transactionId ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  Text(
                    'Tanggal',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                  ),
                  Text(
                    widget.args.data.payment != null
                        ? widget.args.data.payment["paid_at"] != null
                            ? widget.args.data.payment["paid_at"]
                            : ''
                        : '',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                ],
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            if (widget.args.data.payment != null)
              CustomContainerRounded(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Pembayaran',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tagihan',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                        Text(
                          AppUtil().formattedMoneyIDR(widget.args.data.price) ??
                              '',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                      ],
                    ),
                    SizedBox(height: _screen.heightDefault(context) / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Administrasi',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                        Text(
                          AppUtil().formattedMoneyIDR(
                                  _dataHistory?.data?.rajabillerAdminFee) ??
                              '',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                      ],
                    ),
                    SizedBox(height: _screen.heightDefault(context) / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Pembayaran',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                        Text(
                          AppUtil().formattedMoneyIDR(widget.args.data.price) ??
                              '',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomContainerRounded(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                  Text(
                    widget.args.data.payment != null
                        ? widget.args.data.payment["payment_method"] == 'zipay'
                            ? 'Zipay'
                            : 'Virtual Account'
                        : "-",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (waiting.contains(widget.args.data.payment != null
                  ? widget.args.data.payment["status"]
                  : "")),
              child: Column(
                children: [
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomButtonRaised(
                    onTap: () {
                      if (_dataHistory?.data?.payment?.paymentMethod == 'va') {
                        if (_dataHistory.data.payment.vaAccountNumber != null) {
                          var dataBank = DataBank(
                              bankCode: _dataHistory.data.payment.vaBankCode,
                              bankName: '',
                              bankLogo: '');
                          var data = PaymentFinalModel(
                              noTransaction: _dataHistory.data.transactionId,
                              type: _dataHistory.data.transactionType,
                              bank: dataBank,
                              fromMenu: 'history',
                              va: _dataHistory.data.payment.vaAccountNumber);
                          MyNavigator.goToHomePaymentBank(
                              context, PaymentBankArguments(data));
                        } else {
                          var dataBank = DataBank(
                              bankCode: _dataHistory.data.payment.vaBankCode,
                              bankName: '',
                              bankLogo: '');
                          var data = PaymentFinalModel(
                              noTransaction: _dataHistory.data.transactionId,
                              type: _dataHistory.data.transactionType,
                              bank: dataBank,
                              fromMenu: 'history',
                              va: '');
                          MyNavigator.goToHomePaymentBank(
                              context, PaymentBankArguments(data));
                        }
                      } else if (_dataHistory?.data?.payment?.paymentMethod ==
                          'zipay') {
                        var data = PaymentFinalModel(
                            noTransaction: _dataHistory.data.transactionId,
                            type: _dataHistory.data.transactionType,
                            fromMenu: 'history',
                            va: '');
                        MyNavigator.goToHomePaymentZipay(
                            context, PaymentZipayArguments(data));
                      }
                    },
                    isCompleted: true,
                    title: 'Bayar Sekarang',
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailTransactionBillerArguments {
  final ItemHistoryTransaction data;

  DetailTransactionBillerArguments(this.data);
}
