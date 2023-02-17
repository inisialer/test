import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_final.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_information_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PaymentZipayScreen extends StatefulWidget {
  final PaymentZipayArguments args;

  const PaymentZipayScreen({Key key, this.args}) : super(key: key);

  @override
  _PaymentZipayScreenState createState() => _PaymentZipayScreenState();
}

class _PaymentZipayScreenState extends State<PaymentZipayScreen> {
  final _screen = ScreenUtil();
  TextEditingController _pin = TextEditingController();
  bool _isCompletedPin = false;
  String _currentPin = '';
  PaymentBloc _paymentBloc;
  String transaksiID;

  @override
  void initState() {
    super.initState();
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    PaymentZipayArguments args = ModalRoute.of(context).settings.arguments;
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is BillerPaymentMethodFailedState) {
          EasyLoading.dismiss();
        }
        if (state is ConfirmZipayPaymentSuccessState) {
          EasyLoading.dismiss();
          MyNavigator.goToHomePaymentInformation(
              context,
              PaymentInformationArguments(
                  state.data.data.status, args.data.fromMenu));
        } else if (state is ConfirmZipayPaymentFailedState) {
          EasyLoading.dismiss();
          _currentPin = '';
          _pin.text = '';
          if (state.message == 'timeout') {
            MyNavigator.goToHomePaymentInformation(context,
                PaymentInformationArguments('pending', args.data.fromMenu));
          }
        }
      },
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'PIN',
            body: ListView(
              children: [
                SizedBox(height: _screen.heightDefault(context) / 12),
                Center(
                  child: Text(
                    'Masukkan PIN\nUntuk Melanjutkan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 24),
                Container(
                  height: _screen.heightDefault(context) / 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE)),
                  padding: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 10),
                  margin: EdgeInsets.symmetric(
                      horizontal: _screen.widthDefault(context) / 8),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor:
                          AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      disabledColor:
                          AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      activeFillColor:
                          AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      selectedColor:
                          AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      inactiveColor:
                          AppUtil().parseHexColor(CustomColors.GAINSBORO),
                      fieldWidth: _screen.widthDefault(context) / 14,
                    ),
                    autoDisposeControllers: false,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.go,
                    animationDuration: Duration(milliseconds: 300),
                    controller: _pin,
                    onCompleted: (v) {
                      setState(() {
                        _isCompletedPin = true;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        if (value.length < 6) _isCompletedPin = false;
                        _currentPin = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: _screen.heightDefault(context) / 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _pin,
                        builder: (context, value, child) {
                          return CustomButtonRaised(
                            onTap: () {
                              EasyLoading.show(
                                status: 'Loading...',
                                maskType: EasyLoadingMaskType.black,
                              );

                              _paymentBloc.add(ConfirmZipayPaymentEvent(
                                  transactionId: args.data.noTransaction,
                                  zipayPin: _currentPin));

                              print('PIN $_currentPin is $_isCompletedPin');
                            },
                            isCompleted: _pin.text.length == 6,
                            title: 'Bayar',
                          );
                        }),
                    SizedBox(width: _screen.widthDefault(context) / 16),
                    CustomButtonOutline(
                      onTap: () {
                        MyNavigator.goClose(context);
                      },
                      title: 'Batal',
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class PaymentZipayArguments {
  final PaymentFinalModel data;

  PaymentZipayArguments(this.data);
}
