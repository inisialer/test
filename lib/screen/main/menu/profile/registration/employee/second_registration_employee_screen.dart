import 'dart:convert';

import 'package:alhikmah_app/bloc/master/bloc.dart';
import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/second_registration_employee_payload_model.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_dropdown_form.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class SecondRegistrationEmployeeScreen extends StatefulWidget {
  const SecondRegistrationEmployeeScreen({Key key}) : super(key: key);

  @override
  _SecondRegistrationEmployeeScreenState createState() =>
      _SecondRegistrationEmployeeScreenState();
}

class _SecondRegistrationEmployeeScreenState
    extends State<SecondRegistrationEmployeeScreen> {
  final _screen = ScreenUtil();
  final _formKey = GlobalKey<FormState>();
  MemberRegistrationBloc _memberRegistrationBloc;
  MasterBloc _masterBloc;

  SecondRegistrationEmployeePayloadModel _payload =
      SecondRegistrationEmployeePayloadModel();

  String _job;
  List<dynamic> _jobs = [];

  @override
  void initState() {
    super.initState();
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
    _masterBloc = BlocProvider.of<MasterBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _masterBloc.add(JobEvent());
  }

  MoneyMaskedTextController penhasilanPokokController =
      MoneyMaskedTextController(
          leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController penghasilanTambahanController =
      MoneyMaskedTextController(
          leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController penghasilanPertahunController =
      MoneyMaskedTextController(
          leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UtilBloc, UtilState>(
          listener: (context, state) {
            if (state is SetDropdownState) {
              if (state.category == 'pekerjaan') {
                setState(() {
                  _job = state.item;
                  _payload.job = state.item;
                });
              }
            }
          },
        ),
        BlocListener<MasterBloc, MasterState>(
          listener: (context, state) {
            if (state is GetJobSuccessState) {
              var jobs = JsonDecoder().convert(jsonEncode(state.data.data));
              _jobs = jobs;
              EasyLoading.dismiss();
            } else if (state is GetJobFailedState) {
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
                    child: CustomText(text: 'Data Pekerja', fontSize: 20),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Pekerjaan',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomDropdownForm(
                    itemValue: _job,
                    itemData: _jobs,
                    idKey: 'value',
                    nameKey: 'value',
                    category: 'pekerjaan',
                    hint: 'Pilih pekerjaan',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Nama perusahaan',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Nama perusahaan harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.companyName = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Alamat perusahaan',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.streetAddress,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Alamat perusahaan harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.companyAddress = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'No. Telepon/Fax/Ext',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.phone,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isNumber: true,
                    maxLength: 16,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'No. Telepon/Fax/Ext harus di isi!';
                      }
                      if(value.length < 8) {
                        return 'No. Telepon/Fax/Ext minimal 8 karakter';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.companyPhone = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Divisi/Jabatan/Bagian',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Posisi pekerjaan harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.jobPosition = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Bidang usaha',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Bidang usaha harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.companyField = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Lama bekerja (Tahun)',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.number,
                    isNumber: true,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Lama bekerja harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.workingYear = int.parse(value);
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Penghasilan pokok pertahun',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    controllerMaskMoney: penhasilanPokokController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Penghasilan pokok harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      var val = value.replaceAll(RegExp(r'Rp '), '');
                      value = val.replaceAll('.', '');
                      _payload.mainIncome = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Sumber Penghasilan Tambahan',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    controllerMaskMoney: penghasilanTambahanController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Sumber penghasilan tambahan harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      var val = value.replaceAll(RegExp(r'Rp '), '');
                      value = val.replaceAll('.', '');
                      _payload.additionalIncomeSource = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Penghasilan Tambahan Petahun',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Penghasilan tambahan harus di isi!';
                      }
                      return null;
                    },
                    controllerMaskMoney: penghasilanPertahunController,
                    onSaved: (String value) {
                      var val = value.replaceAll(RegExp(r'Rp '), '');
                      value = val.replaceAll('.', '');
                      _payload.additionalIncome = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 24),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    CustomButtonRaised(
                        title: 'Lanjut',
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (_job == null) {
                              AppUtil.showToast("Pilih pekerjaan");
                            } else {
                              EasyLoading.show(
                                status: 'Loading...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              _memberRegistrationBloc.add(
                                  SecondRegistrationEmployeeEvent(
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
