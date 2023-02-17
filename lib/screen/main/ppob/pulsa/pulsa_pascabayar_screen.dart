import 'package:alhikmah_app/bloc/ppob/pulsa/bloc.dart';
import 'package:alhikmah_app/model/ppob/pulsa/inquiry_pulsa_pascabayar_model.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_pascabayar_payment_screen.dart';
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

class PulsaPascabayarScreen extends StatefulWidget {
  const PulsaPascabayarScreen({Key key}) : super(key: key);

  @override
  _PulsaPascabayarScreenState createState() => _PulsaPascabayarScreenState();
}

class _PulsaPascabayarScreenState extends State<PulsaPascabayarScreen> {
  TextEditingController _noPhone = TextEditingController();
  final _screen = ScreenUtil();
  String _phone = '';
  bool _isShowDetail = false;
  PulsaBloc _pulsaBloc;
  InquiryPulsaPascabayarModel _inquiryPulsaPascabayarModel;

  @override
  void initState() {
    super.initState();
    _pulsaBloc = BlocProvider.of<PulsaBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PulsaBloc, PulsaState>(
      listener: (context, state) {
        if (state is GetInquiryPulsaPascabayarSuccessState) {
          _isShowDetail = true;
          _inquiryPulsaPascabayarModel = state.data;
          EasyLoading.dismiss();
        } else if (state is GetInquiryPulsaPascabayarFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PulsaBloc, PulsaState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Pascabayar',
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _screen.widthDefault(context) / 16),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      SizedBox(height: _screen.heightDefault(context) / 20),
                      CustomText(text: 'No. Telepon'),
                      ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _noPhone,
                          builder: (context, value, child) {
                            return CustomTextFieldNumber(controller: _noPhone);
                          }),
                      SizedBox(height: _screen.heightDefault(context) / 40),
                      Column(
                        children: [
                          ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _noPhone,
                              builder: (context, value, child) {
                                return CustomButtonRaised(
                                  onTap: () {
                                    setState(() {
                                      _isShowDetail = false;
                                      EasyLoading.show(
                                        status: 'Loading...',
                                        maskType: EasyLoadingMaskType.black,
                                      );
                                      _pulsaBloc.add(
                                          InquiryPulsaPascabayarEvent(
                                              phoneNumber:
                                                  _noPhone.text.trim()));
                                      _phone = _noPhone.text;
                                      AppUtil().hideKeyboard(context);
                                    });
                                  },
                                  isCompleted: _noPhone.text.length > 9,
                                  title: 'Lihat Tagihan',
                                );
                              }),
                        ],
                      ),
                      Visibility(
                          visible: _isShowDetail,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Provider',
                                style: descTextStyle,
                              ),
                              Text(
                                _inquiryPulsaPascabayarModel?.data?.provider ??
                                    '',
                                style: titleHeadingTextStyle,
                              ),
                              SizedBox(
                                  height: _screen.heightDefault(context) / 40),
                              Text(
                                'No. Telepon',
                                style: descTextStyle,
                              ),
                              Text(
                                _phone,
                                style: titleHeadingTextStyle,
                              ),
                              SizedBox(
                                  height: _screen.heightDefault(context) / 40),
                              Text(
                                'Name',
                                style: descTextStyle,
                              ),
                              Text(
                                _inquiryPulsaPascabayarModel
                                        ?.data?.customerName ??
                                    '',
                                style: titleHeadingTextStyle,
                              ),
                              SizedBox(
                                  height: _screen.heightDefault(context) / 40),
                              Text(
                                'Detail Pembayaran',
                                style: descTextStyle,
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
                                            _inquiryPulsaPascabayarModel
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
                                            _inquiryPulsaPascabayarModel
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
                                            _inquiryPulsaPascabayarModel
                                                ?.data?.totalNominal) ??
                                        'Rp 0',
                                    style: titleHeadingTextStyle,
                                  ),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                  Visibility(
                    visible: _isShowDetail,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: _screen.heightDefault(context) / 20),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ValueListenableBuilder<TextEditingValue>(
                                valueListenable: _noPhone,
                                builder: (context, value, child) {
                                  return CustomButtonRaised(
                                    onTap: () {
                                      setState(() {
                                        if (_isShowDetail) {
                                          var data = PaymentModel(
                                              no: _noPhone.text,
                                              name: _inquiryPulsaPascabayarModel
                                                  .data.customerName,
                                              bill: _inquiryPulsaPascabayarModel
                                                  .data.nominal,
                                              admin:
                                                  _inquiryPulsaPascabayarModel
                                                      .data.adminFee,
                                              total:
                                                  _inquiryPulsaPascabayarModel
                                                      .data.totalNominal,
                                              pascabayarNo: _noPhone.text,
                                              pascabayarOperator:
                                                  _inquiryPulsaPascabayarModel
                                                      .data.provider,
                                              pascabayarName:
                                                  _inquiryPulsaPascabayarModel
                                                      .data.customerName,
                                              noTransaction:
                                                  _inquiryPulsaPascabayarModel
                                                      .data.transactionId);
                                          MyNavigator.goToHomePascabayarPayment(
                                              context,
                                              PulsaPascabayarPaymentArguments(
                                                  data));
                                        }
                                      });
                                    },
                                    isCompleted: _noPhone.text.isNotEmpty,
                                    title: 'Lanjut',
                                  );
                                }),
                            SizedBox(width: _screen.widthDefault(context) / 16),
                            CustomButtonOutline(
                              onTap: () {
                                setState(() {
                                  _isShowDetail = false;
                                  _noPhone.clear();
                                });
                              },
                              title: 'Batal',
                            ),
                          ],
                        ),
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
