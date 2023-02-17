import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_confirm.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_confirm_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_textfield_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PdamPaymentScreen extends StatefulWidget {
  const PdamPaymentScreen({Key key}) : super(key: key);

  @override
  _PdamPaymentScreenState createState() => _PdamPaymentScreenState();
}

class _PdamPaymentScreenState extends State<PdamPaymentScreen> {
  final _screen = ScreenUtil();
  PdamPaymentArguments args;
  TextEditingController _noMember = TextEditingController();
  TextEditingController _totalBill = TextEditingController();
  DataBank _itemBank = DataBank(bankLogo: '', bankName: '', bankCode: '');
  PaymentBloc _paymentBloc;

  @override
  void initState() {
    super.initState();
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    _noMember.text = args.data.no;
    _totalBill.text = AppUtil().formattedMoneyIDR(args.data.total);
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is BillerPaymentMethodSuccessState) {
          EasyLoading.dismiss();
          var data = PaymentConfirmModel(
              noOrName: args.data.no,
              type: 'PDAM',
              noTransaction: args.data.noTransaction,
              date: AppUtil().dateTimeNow(),
              bill: args.data.bill,
              admin: args.data.admin,
              total: args.data.total,
              typeMenu: 'pdam',
              paymentMethod: (_itemBank.bankName == 'Zipay') ? 'ZIPAY' : 'BANK',
              menuDataNoOrName: 'No. Pelanggan',
              menuDataType: 'Pembayaran',
              pdamName: args.data.pdamName,
              pdamCity: args.data.pdamCity,
              pdamNo: args.data.pdamNo,
              pdamPeriod: args.data.pdamPeriod,
              bank: _itemBank);
          MyNavigator.goToHomePaymentConfirm(
              context, PaymentConfirmArguments(data));
        } else if (state is BillerPaymentMethodFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Pembayaran',
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _screen.widthDefault(context) / 16),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      SizedBox(height: _screen.heightDefault(context) / 20),
                      CustomText(text: 'No. Pelanggan'),
                      CustomTextFieldNumber(
                        controller: _noMember,
                        isReadOnly: true,
                        isSuffix: false,
                      ),
                      SizedBox(height: _screen.heightDefault(context) / 40),
                      CustomText(text: 'Total Tagihan'),
                      CustomTextFieldNumber(
                        controller: _totalBill,
                        isReadOnly: true,
                        isSuffix: false,
                      ),
                      SizedBox(height: _screen.heightDefault(context) / 40),
                      GestureDetector(
                        onTap: () async {
                          var results = await Navigator.pushNamed(
                              context, '/home-payment-method');
                          if (results != null) {
                            setState(() {
                              _itemBank = results;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppUtil()
                                  .parseHexColor(CustomColors.WHITE_SMOKE),
                              borderRadius: BorderRadius.circular(48)),
                          padding: EdgeInsets.symmetric(
                              horizontal: _screen.widthDefault(context) / 24,
                              vertical: _screen.heightDefault(context) / 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (_itemBank.bankName == '')
                                    ? 'Metode Pembayaran'
                                    : (_itemBank.bankName == 'Zipay')
                                        ? 'Zipay'
                                        : 'Transfer Bank (${_itemBank.bankName})',
                                style: TextStyle(
                                    color: AppUtil()
                                        .parseHexColor(CustomColors.NOBEL),
                                    fontWeight: FontWeight.w800),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: AppUtil().parseHexColor(
                                    CustomColors.GRANNY_SMITH_APPLE),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: _screen.heightDefault(context) / 100),
                      Visibility(
                          visible: _itemBank.bankName != '',
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      _screen.widthDefault(context) / 40),
                              child: Image.asset(
                                _itemBank.bankLogo,
                                width: _screen.widthDefault(context) / 5,
                                height: _screen.heightDefault(context) / 18,
                              ),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: _screen.heightDefault(context) / 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButtonRaised(
                            onTap: () {
                              EasyLoading.show(
                                status: 'Loading...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              _paymentBloc.add(BillerPaymentMethodEvent(
                                  paymentMethod: (_itemBank.bankName == 'Zipay')
                                      ? 'zipay'
                                      : 'va',
                                  transactionId: args.data.noTransaction,
                                  vaBankCode: (_itemBank.bankName == 'Zipay')
                                      ? ''
                                      : _itemBank.bankCode));
                            },
                            isCompleted: _itemBank.bankName != '',
                            title: 'Lanjut',
                          ),
                          SizedBox(width: _screen.widthDefault(context) / 16),
                          CustomButtonOutline(
                            onTap: () {
                              MyNavigator.goClose(context);
                            },
                            title: 'Batal',
                          ),
                        ],
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

class PdamPaymentArguments {
  final PaymentModel data;

  PdamPaymentArguments(this.data);
}
