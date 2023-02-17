import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_final.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_container_rounded.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'package:alhikmah_app/screen/main/ppob/payment/widget/item_method_bank.dart';

class PaymentBankScreen extends StatefulWidget {
  const PaymentBankScreen({Key key}) : super(key: key);

  @override
  _PaymentBankScreenState createState() => _PaymentBankScreenState();
}

class _PaymentBankScreenState extends State<PaymentBankScreen> {
  bool _isVisibleMobile = false;
  bool _isVisibleAtm = false;
  bool _isVisibleInternet = false;

  final _screen = ScreenUtil();
  DataBank _dataBank;
  String _virtualAccount = '';

  PaymentBloc _paymentBloc;

  @override
  void initState() {
    super.initState();
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    PaymentBankArguments args = ModalRoute.of(context).settings.arguments;

    _dataBank = args.data.bank;

    if (_virtualAccount == '') {
      _virtualAccount = args.data.va;
    }

    if (_virtualAccount == '') {
      EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.black,
      );
      _paymentBloc
          .add(ConfirmVaPaymentEvent(transactionId: args.data.noTransaction));

      if (args.data.fromMenu == 'history' && _dataBank?.bankLogo == null) {
        _paymentBloc.add(VaBankEvent());
      }
    } else {
      if (args.data.fromMenu == 'history' && _dataBank?.bankLogo == null) {
        EasyLoading.show(
          status: 'Loading...',
          maskType: EasyLoadingMaskType.black,
        );
        _paymentBloc.add(VaBankEvent());
      }
    }

    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is ConfirmVaPaymentSuccessState) {
          _virtualAccount = state.data.data.accountNumber;
          if (args.data.fromMenu == 'home') {
            setState(() {
              _dataBank = args.data.bank;
            });
            EasyLoading.dismiss();
          }
        } else if (state is ConfirmVaPaymentFailedState) {
          EasyLoading.dismiss();
        }
        if (state is GetVaBankSuccessState) {
          EasyLoading.dismiss();
          final x = state.data.data.firstWhere(
              (element) => element.bankCode == args.data.bank.bankCode);
          _dataBank = x;
        } else if (state is GetVaBankFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Cara Pembayaran',
            body: Padding(
              padding: EdgeInsets.only(
                  top: _screen.heightDefault(context) / 100,
                  left: _screen.widthDefault(context) / 16,
                  right: _screen.widthDefault(context) / 16),
              child: ListView(
                children: [
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomContainerRounded(
                    paddingVertical: 0,
                    widget: Column(
                      children: [
                        SizedBox(height: _screen.heightDefault(context) / 100),
                        Image.network(
                          _dataBank?.bankLogo ?? '',
                          width: _screen.widthDefault(context) / 5,
                          height: _screen.heightDefault(context) / 18,
                        ),
                        SizedBox(height: _screen.heightDefault(context) / 100),
                        Text(
                          'Nomor ${_dataBank?.bankName} Virtual Account',
                          style: TextStyle(
                              fontSize: 12,
                              color:
                                  AppUtil().parseHexColor(CustomColors.SILVER),
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: _screen.heightDefault(context) / 100),
                        Text(
                          _virtualAccount ?? '',
                          style: TextStyle(
                              color: AppUtil().parseHexColor(
                                  CustomColors.GRANNY_SMITH_APPLE),
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        SizedBox(height: _screen.heightDefault(context) / 64),
                        MaterialButton(
                          onPressed: () {
                            FlutterClipboard.copy(_virtualAccount
                                    .toString()
                                    .replaceAll(RegExp(r'\s+'), ''))
                                .then((value) => AppUtil.showToast(
                                    'Virtual Account di salin ke papan klik'));
                          },
                          child: Text(
                            'Salin',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppUtil().parseHexColor(
                                    CustomColors.GRANNY_SMITH_APPLE)),
                          ),
                          color: Colors.white,
                          disabledColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: AppUtil().parseHexColor(
                                    CustomColors.GRANNY_SMITH_APPLE)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        SizedBox(height: _screen.heightDefault(context) / 100),
                      ],
                    ),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomContainerRounded(
                    widget: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisibleMobile = !_isVisibleMobile;
                        });
                      },
                      child: _ItemMethodBank(
                        isVisible: _isVisibleMobile,
                        title: 'Mobile Banking',
                        desc:
                            '1. Buka Aplikasi BSI MOBILE\n2. Buka BELI > TOP UP > ZIPAY\n3. Masukan $_virtualAccount\n4. Masukan nominal top up\n5. Ikuti instrusksi untuk melanjutkan',
                      ),
                    ),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  CustomContainerRounded(
                    widget: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisibleInternet = !_isVisibleInternet;
                        });
                      },
                      child: _ItemMethodBank(
                        isVisible: _isVisibleInternet,
                        title: 'Internet Banking',
                        desc:
                            '1. Buka Aplikasi BSI MOBILE\n2. Buka BELI > TOP UP > ZIPAY\n3. Masukan $_virtualAccount\n4. Masukan nominal top up\n5. Ikuti instrusksi untuk melanjutkan',
                      ),
                    ),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  CustomContainerRounded(
                    widget: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisibleAtm = !_isVisibleAtm;
                        });
                      },
                      child: _ItemMethodBank(
                        isVisible: _isVisibleAtm,
                        title: 'ATM',
                        desc:
                            '1. Buka Aplikasi BSI MOBILE\n2. Buka BELI > TOP UP > ZIPAY\n3. Masukan $_virtualAccount\n4. Masukan nominal top up\n5. Ikuti instrusksi untuk melanjutkan',
                      ),
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

class PaymentBankArguments {
  final PaymentFinalModel data;

  PaymentBankArguments(this.data);
}
