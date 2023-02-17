import 'package:alhikmah_app/bloc/ppob/pulsa/bloc.dart';
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

class PulsaPrabayarPaymentScreen extends StatefulWidget {
  const PulsaPrabayarPaymentScreen({Key key}) : super(key: key);

  @override
  _PulsaPrabayarPaymentScreenState createState() =>
      _PulsaPrabayarPaymentScreenState();
}

class _PulsaPrabayarPaymentScreenState
    extends State<PulsaPrabayarPaymentScreen> {
  PulsaPrabayarPaymentArguments args;
  final _screen = ScreenUtil();
  TextEditingController _noPhone = TextEditingController();
  TextEditingController _totalBill = TextEditingController();
  DataBank _itemBank = DataBank(bankLogo: '', bankName: '', bankCode: '');
  PulsaBloc _pulsaBloc;

  @override
  void initState() {
    super.initState();
    _pulsaBloc = BlocProvider.of<PulsaBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    _noPhone.text = args.data.no;
    _totalBill.text = AppUtil().formattedMoneyIDR(args.data.total);
    return BlocListener<PulsaBloc, PulsaState>(
      listener: (context, state) {
        if (state is RequestPulsaPrabayarSuccessState) {
          EasyLoading.dismiss();
          var data = PaymentConfirmModel(
              noOrName: args.data.no,
              type: args.data.pulsaDesc,
              noTransaction: state.data.data.transactionId,
              date: AppUtil().dateTimeNow(),
              bill: args.data.bill,
              admin: args.data.admin,
              total: args.data.total,
              typeMenu: 'pulsa',
              paymentMethod: (_itemBank.bankName == 'Zipay') ? 'ZIPAY' : 'BANK',
              menuDataNoOrName: 'No. Telepon',
              menuDataType: 'Pembayaran',
              pulsaNo: args.data.pulsaNo,
              pulsaType: args.data.pulsaType,
              bank: _itemBank);
          MyNavigator.goToHomePaymentConfirm(
              context, PaymentConfirmArguments(data));
        } else if (state is RequestPulsaPrabayarFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PulsaBloc, PulsaState>(
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
                      CustomText(text: 'No. Telepon'),
                      CustomTextFieldNumber(
                        controller: _noPhone,
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
                              child: _itemBank.bankName == 'Zipay'
                                  ? Image.asset(
                                      _itemBank.bankLogo,
                                      width: _screen.widthDefault(context) / 5,
                                      height:
                                          _screen.heightDefault(context) / 18,
                                    )
                                  : Image.network(
                                      _itemBank.bankLogo,
                                      width: _screen.widthDefault(context) / 5,
                                      height:
                                          _screen.heightDefault(context) / 18,
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
                              _pulsaBloc.add(RequestPulsaPrabayarEvent(
                                  paymentMethod: (_itemBank.bankName == 'Zipay')
                                      ? 'zipay'
                                      : 'va',
                                  phoneNumber: args.data.no,
                                  productCode: args.data.pulsaCode,
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

class PulsaPrabayarPaymentArguments {
  final PaymentModel data;

  PulsaPrabayarPaymentArguments(this.data);
}
