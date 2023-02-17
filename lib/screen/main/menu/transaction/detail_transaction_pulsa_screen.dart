import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/payment/history_detail_pulsa_model.dart';
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
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DetailTransactionPulsaScreen extends StatefulWidget {
  const DetailTransactionPulsaScreen({Key key}) : super(key: key);

  @override
  _DetailTransactionPulsaScreenState createState() =>
      _DetailTransactionPulsaScreenState();
}

class _DetailTransactionPulsaScreenState
    extends State<DetailTransactionPulsaScreen> {
  final _screen = ScreenUtil();
  PaymentBloc _paymentBloc;
  HistoryDetailPulsaModel _dataHistory;

  @override
  void initState() {
    super.initState();
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    DetailTransactionPulsaArguments args =
        ModalRoute.of(context).settings.arguments;
    _paymentBloc
        .add(DetailHistoryPulsaEvent(transactionId: args.data.transactionId));

    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is DetailHistoryPulsaSuccessState) {
          EasyLoading.dismiss();
          _dataHistory = state.data;
        } else if (state is DetailHistoryPulsaFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
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
                  CustomContainerStatus(status: args.data.status.toLowerCase()),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomContainerRounded(
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Provider',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.NOBEL)),
                        ),
                        Text(
                          _dataHistory?.data?.provider ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                        SizedBox(height: _screen.heightDefault(context) / 100),
                        Text(
                          'No. HP',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.NOBEL)),
                        ),
                        Text(
                          _dataHistory?.data?.phoneNumber ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                        SizedBox(height: _screen.heightDefault(context) / 100),
                        Text(
                          'No. Ref',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.NOBEL)),
                        ),
                        Text(
                          _dataHistory?.data?.ref1 ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                        SizedBox(height: _screen.heightDefault(context) / 100),
                        Text(
                          'Tanggal',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.NOBEL)),
                        ),
                        Text(
                          AppUtil().formattedDateServer(
                              _dataHistory?.data?.createdAt ?? '', context),
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomContainerRounded(
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Pembayaran',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tagihan',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.MORTAR)),
                            ),
                            Text(
                              AppUtil().formattedMoneyIDR(
                                      _dataHistory?.data?.price) ??
                                  '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.MORTAR)),
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
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.MORTAR)),
                            ),
                            Text(
                              'Rp 0',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.MORTAR)),
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
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.MORTAR)),
                            ),
                            Text(
                              AppUtil().formattedMoneyIDR(
                                      _dataHistory?.data?.payment?.amount) ??
                                  '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.MORTAR)),
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
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                        Text(
                          (_dataHistory?.data?.payment?.paymentMethod ==
                                  'zipay')
                              ? 'Zipay'
                              : 'Virtual Account',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color:
                                  AppUtil().parseHexColor(CustomColors.MORTAR)),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (_dataHistory?.data?.status == 'waiting-payment'),
                    child: Column(
                      children: [
                        SizedBox(height: _screen.heightDefault(context) / 40),
                        CustomButtonRaised(
                          onTap: () {
                            if (_dataHistory?.data?.payment?.paymentMethod ==
                                'va') {
                              if (_dataHistory.data.payment.vaAccountNumber !=
                                  null) {
                                var dataBank = DataBank(
                                    bankCode:
                                        _dataHistory.data.payment.vaBankCode,
                                    bankName: '',
                                    bankLogo: '');
                                var data = PaymentFinalModel(
                                    noTransaction: 'xyz',
                                    type: 'pulsa',
                                    bank: dataBank,
                                    fromMenu: 'history',
                                    va: _dataHistory
                                        .data.payment.vaAccountNumber);
                                MyNavigator.goToHomePaymentBank(
                                    context, PaymentBankArguments(data));
                              }
                            } else if (_dataHistory
                                    ?.data?.payment?.paymentMethod ==
                                'zipay') {
                              var data = PaymentFinalModel(
                                  noTransaction: 'xyz',
                                  type: 'pulsa',
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
        },
      ),
    );
  }
}

class DetailTransactionPulsaArguments {
  final ItemHistoryTransaction data;

  DetailTransactionPulsaArguments(this.data);
}
