import 'package:alhikmah_app/bloc/ppob/pln/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/model/ppob/pln/inquiry_pln_prabayar_model.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment.dart';
import 'package:alhikmah_app/screen/main/ppob/pln/pln_payment_screen.dart';
import 'package:alhikmah_app/util/app_style.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_dropdown.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_textfield_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PlnPrabayarScreen extends StatefulWidget {
  const PlnPrabayarScreen({Key key}) : super(key: key);

  @override
  _PlnPrabayarScreenState createState() => _PlnPrabayarScreenState();
}

class _PlnPrabayarScreenState extends State<PlnPrabayarScreen> {
  TextEditingController _noMeter = TextEditingController();
  final _screen = ScreenUtil();
  bool _isShowDetail = false;
  PlnBloc _plnBloc;
  InquiryPlnPrabayarModel _inquiryPlnPrabayarModel;
  String _nominalToken;
  List<String> _nominalsToken = [
    '20.000',
    '50.000',
    '100.000',
    '200.000',
    '500.000',
    '1.000.000',
    '5.000.000',
    '10.000.000',
    '50.000.000'
  ];

  @override
  void initState() {
    super.initState();
    _plnBloc = BlocProvider.of<PlnBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PlnBloc, PlnState>(
          listener: (context, state) {
            if (state is GetInquiryPlnPrabayarSuccessState) {
              _isShowDetail = true;
              _inquiryPlnPrabayarModel = state.data;
              EasyLoading.dismiss();
            } else if (state is GetInquiryPlnPrabayarFailedState) {
              EasyLoading.dismiss();
            }
          },
        ),
        BlocListener<UtilBloc, UtilState>(
          listener: (context, state) {
            if (state is SetDropdownState) {
              if (state.category == 'nominalToken') {
                _nominalToken = state.item;
                _isShowDetail = false;
              }
            }
          },
        )
      ],
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
                        SizedBox(height: _screen.heightDefault(context) / 100),
                        CustomText(text: 'Nominal'),
                        BlocBuilder<UtilBloc, UtilState>(
                          builder: (context, state) {
                            return CustomDropdown(
                              item: _nominalToken,
                              items: _nominalsToken,
                              category: 'nominalToken',
                              hint: 'Pilih Nominal',
                            );
                          },
                        ),
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
                                      _inquiryPlnPrabayarModel
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
                                              _inquiryPlnPrabayarModel
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
                                              _inquiryPlnPrabayarModel
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
                                              _inquiryPlnPrabayarModel
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
                                          var data = PaymentModel(
                                              no: _noMeter.text,
                                              bill: _inquiryPlnPrabayarModel
                                                  .data.nominal,
                                              admin: _inquiryPlnPrabayarModel
                                                  .data.adminFee,
                                              total: _inquiryPlnPrabayarModel
                                                  .data.totalNominal,
                                              plnName: _inquiryPlnPrabayarModel
                                                  .data.customerName,
                                              plnNo: _noMeter.text,
                                              noTransaction:
                                                  _inquiryPlnPrabayarModel
                                                      .data.transactionId);
                                          MyNavigator.goToHomePlnPayment(
                                              context,
                                              PlnPaymentArguments(data));
                                        } else {
                                          EasyLoading.show(
                                            status: 'Loading...',
                                            maskType: EasyLoadingMaskType.black,
                                          );
                                          var realNominal =
                                              _nominalToken.split('.').join("");
                                          _plnBloc.add(InquiryPlnPrabayarEvent(
                                              noMeter: _noMeter.text.trim(),
                                              nominal: int.parse(realNominal)));
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
