import 'dart:convert';

import 'package:alhikmah_app/bloc/ppob/pdam/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/model/ppob/pdam/inquiry_pdam_model.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment.dart';
import 'package:alhikmah_app/screen/main/ppob/pdam/pdam_payment_screen.dart';
import 'package:alhikmah_app/util/app_style.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_dropdown_form.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_textfield_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PdamScreen extends StatefulWidget {
  const PdamScreen({Key key}) : super(key: key);

  @override
  _PdamScreenState createState() => _PdamScreenState();
}

class _PdamScreenState extends State<PdamScreen> {
  final _screen = ScreenUtil();
  String _pdamArea;
  List<dynamic> _pdamAreas = [];
  bool _isShowDetail = false;
  InquiryPdamModel _inquiryPdamModel;
  TextEditingController _noMember = TextEditingController();
  PdamBloc _pdamBloc;

  String _savedPdamArea;
  String _savedPdamNo;

  @override
  void initState() {
    super.initState();
    _pdamBloc = BlocProvider.of<PdamBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _pdamBloc.add(PdamAreasEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UtilBloc, UtilState>(
          listener: (context, state) {
            if (state is SetDropdownState) {
              if (state.category == 'city') {
                setState(() {
                  _pdamArea = state.item;
                });
              }
            }
          },
        ),
        BlocListener<PdamBloc, PdamState>(
          listener: (context, state) {
            if (state is GetPdamAreasSuccessState) {
              EasyLoading.dismiss();
              var pdamAreas =
                  JsonDecoder().convert(jsonEncode(state.data.data));
              _pdamAreas = pdamAreas;
            } else if (state is GetPdamAreasFailedState) {
              EasyLoading.dismiss();
            } else if (state is GetInquiryPdamSuccessState) {
              _inquiryPdamModel = state.data;
              _isShowDetail = true;
              _savedPdamNo = _noMember.text;
              _savedPdamArea = _pdamArea;
              EasyLoading.dismiss();
            } else if (state is GetInquiryPdamFailedState) {
              EasyLoading.dismiss();
            }
          },
        ),
      ],
      child: BlocBuilder<PdamBloc, PdamState>(
        builder: (context, state) {
          return CustomAppBarDetail(
              title: 'PDAM',
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _screen.widthDefault(context) / 16),
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(height: _screen.heightDefault(context) / 20),
                        CustomText(text: 'Kota'),
                        CustomDropdownForm(
                          itemValue: _pdamArea,
                          itemData: _pdamAreas,
                          idKey: 'id',
                          nameKey: 'area',
                          category: 'city',
                          hint: 'Pilih Kota',
                        ),
                        SizedBox(height: _screen.heightDefault(context) / 40),
                        CustomText(text: 'No. Pelanggan'),
                        ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _noMember,
                            builder: (context, value, child) {
                              return CustomTextFieldNumber(
                                controller: _noMember,
                                isNumber: false,
                                keyboardType: TextInputType.text,
                              );
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
                                  'Nama Pelanggan',
                                  style: descTextStyle,
                                ),
                                Text(
                                  _inquiryPdamModel?.data?.customerName ?? '',
                                  style: titleHeadingTextStyle,
                                ),
                                SizedBox(
                                    height:
                                        _screen.heightDefault(context) / 40),
                                Text(
                                  'Periode Tagihan',
                                  style: descTextStyle,
                                ),
                                Text(
                                  _inquiryPdamModel?.data?.periode ?? '',
                                  style: titleHeadingTextStyle,
                                ),
                                SizedBox(
                                    height:
                                        _screen.heightDefault(context) / 40),
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
                                              _inquiryPdamModel
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
                                              _inquiryPdamModel
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
                                              _inquiryPdamModel
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
                                valueListenable: _noMember,
                                builder: (context, value, child) {
                                  return CustomButtonRaised(
                                    onTap: () {
                                      setState(() {
                                        if (_isShowDetail) {
                                          if (_savedPdamNo != _noMember.text ||
                                              _savedPdamArea != _pdamArea) {
                                            _isShowDetail = false;
                                            EasyLoading.show(
                                              status: 'Loading...',
                                              maskType:
                                                  EasyLoadingMaskType.black,
                                            );
                                            _pdamBloc.add(InquiryPdamEvent(
                                                areaId: _pdamArea,
                                                customerId: _noMember.text));
                                          } else {
                                            var data = PaymentModel(
                                                no: _noMember.text,
                                                name: _inquiryPdamModel
                                                    .data.customerName,
                                                bill: _inquiryPdamModel
                                                    .data.nominal,
                                                admin: _inquiryPdamModel
                                                    .data.adminFee,
                                                total: _inquiryPdamModel
                                                    .data.totalNominal,
                                                pdamName: _inquiryPdamModel
                                                    .data.customerName,
                                                pdamCity: _pdamArea,
                                                pdamNo: _noMember.text,
                                                pdamPeriod: _inquiryPdamModel
                                                    .data.periode,
                                                noTransaction: _inquiryPdamModel
                                                    .data.transactionId);
                                            MyNavigator.goToHomePdamPayment(
                                                context,
                                                PdamPaymentArguments(data));
                                          }
                                        } else {
                                          EasyLoading.show(
                                            status: 'Loading...',
                                            maskType: EasyLoadingMaskType.black,
                                          );
                                          _pdamBloc.add(InquiryPdamEvent(
                                              areaId: _pdamArea,
                                              customerId: _noMember.text));
                                        }
                                      });
                                    },
                                    isCompleted: (_pdamArea != null) &&
                                        _noMember.text.isNotEmpty,
                                    title: 'Lanjut',
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
