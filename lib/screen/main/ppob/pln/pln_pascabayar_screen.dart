import 'package:alhikmah_app/bloc/ppob/pln/bloc.dart';
import 'package:alhikmah_app/model/ppob/pln/inquiry_pln_pascabayar_model.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment.dart';
import 'package:alhikmah_app/screen/main/ppob/pln/pln_payment_screen.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PlnPascabayarScreen extends StatefulWidget {
  const PlnPascabayarScreen({Key key}) : super(key: key);

  @override
  _PlnPascabayarScreenState createState() => _PlnPascabayarScreenState();
}

class _PlnPascabayarScreenState extends State<PlnPascabayarScreen> {
  TextEditingController _noMeter = TextEditingController();
  final _screen = ScreenUtil();
  bool _isShowDetail = false;
  PlnBloc _plnBloc;
  InquiryPlnPascabayarModel _inquiryPlnPascabayarModel;

  String _savedNoMeter;

  @override
  void initState() {
    super.initState();
    _plnBloc = BlocProvider.of<PlnBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlnBloc, PlnState>(
      listener: (context, state) {
        if (state is GetInquiryPlnPascabayarSuccessState) {
          _isShowDetail = true;
          _savedNoMeter = _noMeter.text;
          _inquiryPlnPascabayarModel = state.data;
          EasyLoading.dismiss();
        } else if (state is GetInquiryPlnPascabayarFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PlnBloc, PlnState>(
        builder: (context, state) {
          return CustomAppBarDetail(
              title: 'PLN',
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _screen.widthDefault(context) / 16),
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(height: _screen.heightDefault(context) / 20),
                        CustomText(text: 'No. Meter'),
                        ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _noMeter,
                            builder: (context, value, child) {
                              return CustomTextFieldNumber(
                                  controller: _noMeter);
                            }),
                        SizedBox(height: _screen.heightDefault(context) / 24),
                        Visibility(
                          visible: _isShowDetail,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: _screen.widthDefault(context) / 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Detail Pembayaran',
                                  style: descTextStyle,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nama',
                                      style: titleHeadingTextStyle,
                                    ),
                                    Text(
                                      _inquiryPlnPascabayarModel
                                              ?.data?.customerName ??
                                          '',
                                      style: titleHeadingTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tagihan',
                                      style: titleHeadingTextStyle,
                                    ),
                                    Text(
                                      AppUtil().formattedMoneyIDR(
                                              _inquiryPlnPascabayarModel
                                                  ?.data?.nominal) ??
                                          'Rp 0',
                                      style: titleHeadingTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Admin',
                                      style: titleHeadingTextStyle,
                                    ),
                                    Text(
                                      AppUtil().formattedMoneyIDR(
                                              _inquiryPlnPascabayarModel
                                                  ?.data?.adminFee) ??
                                          'Rp 0',
                                      style: titleHeadingTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Tagihan',
                                      style: titleHeadingTextStyle,
                                    ),
                                    Text(
                                      AppUtil().formattedMoneyIDR(
                                              _inquiryPlnPascabayarModel
                                                  ?.data?.totalNominal) ??
                                          'Rp 0',
                                      style: titleHeadingTextStyle,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
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
                            ValueListenableBuilder<TextEditingValue>(
                                valueListenable: _noMeter,
                                builder: (context, value, child) {
                                  return CustomButtonRaised(
                                    onTap: () {
                                      setState(() {
                                        if (_isShowDetail) {
                                          if (_savedNoMeter != _noMeter.text) {
                                            _isShowDetail = false;
                                            EasyLoading.show(
                                              status: 'Loading...',
                                              maskType:
                                                  EasyLoadingMaskType.black,
                                            );
                                            _plnBloc.add(
                                                InquiryPlnPascabayarEvent(
                                                    noMeter:
                                                        _noMeter.text.trim()));
                                          } else {
                                            var data = PaymentModel(
                                                no: _noMeter.text,
                                                bill: _inquiryPlnPascabayarModel
                                                    .data.nominal,
                                                admin:
                                                    _inquiryPlnPascabayarModel
                                                        .data.adminFee,
                                                total:
                                                    _inquiryPlnPascabayarModel
                                                        .data.totalNominal,
                                                plnName:
                                                    _inquiryPlnPascabayarModel
                                                        .data.customerName,
                                                plnNo: _noMeter.text,
                                                noTransaction:
                                                    _inquiryPlnPascabayarModel
                                                        .data.transactionId);
                                            MyNavigator.goToHomePlnPayment(
                                                context,
                                                PlnPaymentArguments(data));
                                          }
                                        } else {
                                          EasyLoading.show(
                                            status: 'Loading...',
                                            maskType: EasyLoadingMaskType.black,
                                          );
                                          _plnBloc.add(
                                              InquiryPlnPascabayarEvent(
                                                  noMeter:
                                                      _noMeter.text.trim()));
                                        }
                                      });
                                    },
                                    isCompleted: _noMeter.text.isNotEmpty,
                                    title: 'Lanjut',
                                  );
                                }),
                            SizedBox(width: _screen.widthDefault(context) / 16),
                            ValueListenableBuilder<TextEditingValue>(
                                valueListenable: _noMeter,
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
              ));
        },
      ),
    );
  }
}
