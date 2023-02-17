import 'dart:convert';

import 'package:alhikmah_app/bloc/master/bloc.dart';
import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/second_registration_business_owner_payload_model.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/currency_formatter.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_dropdown_form.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SecondRegistrationBusinessOwnerScreen extends StatefulWidget {
  const SecondRegistrationBusinessOwnerScreen({Key key}) : super(key: key);

  @override
  _SecondRegistrationBisnisOwnerScreenState createState() =>
      _SecondRegistrationBisnisOwnerScreenState();
}

class _SecondRegistrationBisnisOwnerScreenState
    extends State<SecondRegistrationBusinessOwnerScreen> {
  final _screen = ScreenUtil();
  final _formKey = GlobalKey<FormState>();
  MemberRegistrationBloc _memberRegistrationBloc;
  MasterBloc _masterBloc;

  SecondRegistrationBusinessOwnerPayloadModel _payload =
      SecondRegistrationBusinessOwnerPayloadModel();

  String _statusBusinessPlace;
  List<dynamic> _statusBusinessPlaces = [];
  String _statusBadanHukumUsaha;
  List<dynamic> _statusBadanHukumUsahas = [
    {"text": "Perusahaan Perseorangan", "value": "perusahaanperseorangan"},
    {"text": "Firma", "value": "firma"},
    {"text": "Koperasi", "value": "koperasi"},
    {"text": "Perseroan Komanditer (CV)", "value": "cv"},
    {"text": "Perseroan Terbatas (PT)", "value": "pt"},
    {"text": "Tidak berbadan Hukum", "value": "tidakberbadanhukum"},
  ];

  @override
  void initState() {
    super.initState();
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
    _masterBloc = BlocProvider.of<MasterBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _masterBloc.add(BusinessPlaceStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UtilBloc, UtilState>(
          listener: (context, state) {
            if (state is SetDropdownState) {
              if (state.category == 'statustempatusaha') {
                setState(() {
                  _statusBusinessPlace = state.item;
                  _payload.statusBusinessPlace = state.item;
                });
              } else if (state.category == 'statusbadanhukumusaha') {
                setState(() {
                  _statusBadanHukumUsaha = state.item;
                  _payload.statusBusinessLegal = state.item;
                });
              }
            }
          },
        ),
        BlocListener<MasterBloc, MasterState>(
          listener: (context, state) {
            if (state is GetBusinessPlaceStatusSuccessState) {
              var statusBusinessPlaces =
                  JsonDecoder().convert(jsonEncode(state.data.data));
              _statusBusinessPlaces = statusBusinessPlaces;
              EasyLoading.dismiss();
            } else if (state is GetBusinessPlaceStatusFailedState) {
              EasyLoading.dismiss();
            }
          },
        ),
      ],
      child: BlocBuilder<MasterBloc, MasterState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  Center(
                    child: CustomText(text: 'Data Pemilik Usaha', fontSize: 20),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Status badan hukum usaha',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  // CustomTextFieldForm(
                  //   keyboardType: TextInputType.name,
                  //   color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  //   isAll: true,
                  //   validator: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'Status bahan hukum harus di isi!';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (String value) {
                  //     _payload.statusBusinessLegal = value;
                  //   },
                  // ),
                  CustomDropdownForm(
                    itemValue: _statusBadanHukumUsaha,
                    itemData: _statusBadanHukumUsahas,
                    idKey: 'value',
                    nameKey: 'text',
                    category: 'statusbadanhukumusaha',
                    hint: 'Status Badan Hukum  Usaha',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Alamat tempat usaha',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Alamat tempat usaha harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.businessAddress = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Nomor telepon usaha',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.phone,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isNumber: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'No. telepon usaha harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.businessPhone = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Status tempat Usaha',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomDropdownForm(
                    itemValue: _statusBusinessPlace,
                    itemData: _statusBusinessPlaces,
                    idKey: 'value',
                    nameKey: 'value',
                    category: 'statustempatusaha',
                    hint: 'Status Tempat Usaha',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Rata-rata omzet perbulan',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.number,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isNumber: true,
                    isAll: true,
                    prefixText: 'Rp. ',
                    formatter: [CurrencyInputFormatter(maxDigits: 20)],
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Rata-rata omzet perbulan harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.averageMonthlyProfit = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 24),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    CustomButtonRaised(
                        title: 'Lanjut',
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (_statusBusinessPlace == null) {
                              AppUtil.showToast("Pilih status usaha");
                            } else if (_statusBadanHukumUsaha == null) {
                              AppUtil.showToast(
                                  "Pilih status badan hukum usaha");
                            } else {
                              EasyLoading.show(
                                status: 'Loading...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              _memberRegistrationBloc.add(
                                  SecondRegistrationBusinessOwnerEvent(
                                      payload: _payload));
                            }
                          }
                        },
                        isCompleted: true)
                  ])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
