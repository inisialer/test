import 'dart:convert';
import 'dart:developer';

import 'package:alhikmah_app/bloc/master/bloc.dart';
import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/memberregistration/registration_member_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/init_registration_member_payload_model.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_dropdown_form.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class InitRegistrationMemberScreen extends StatefulWidget {
  const InitRegistrationMemberScreen({Key key, this.dataMemberRegistration})
      : super(key: key);

  final DataMemberRegistration dataMemberRegistration;

  @override
  _InitRegistrationMemberScreenState createState() =>
      _InitRegistrationMemberScreenState();
}

class _InitRegistrationMemberScreenState
    extends State<InitRegistrationMemberScreen> {
  TextEditingController _birthDate = TextEditingController();

  final _screen = ScreenUtil();
  final _formKey = GlobalKey<FormState>();
  InitRegistrationMemberPayloadModel _payload =
      InitRegistrationMemberPayloadModel();

  String _statusResidence;
  List<dynamic> _statusResidences = [];
  String _lastEducation;
  List<dynamic> _lastEducations = [];
  String _gender;
  List<dynamic> _genders = [
    {"text": "Laki-laki", "value": "male"},
    {"text": "Perempuan", "value": "female"}
  ];
  String _marital;
  List<dynamic> _maritals = [
    {"text": "Menikah", "value": "menikah"},
    {"text": "Belum Menikah", "value": "belum_menikah"},
    {"text": "Janda/Duda", "value": "janda_duda"}
  ];

  String _heir;
  List<dynamic> _heirs = [
    {"text": "Suami/Istri", "value": "suami_istri"},
    {"text": "Anak", "value": "anak"},
    {"text": "Orang Tua", "value": "orang_tua"},
    {"text": "Lainnya", "value": "lainnya"}
  ];
  String _religion;
  List<dynamic> _religions = [
    {"text": "Islam", "value": "islam"},
    {"text": "Katholik", "value": "katholik"},
    {"text": "Protestan", "value": "protestan"},
    {"text": "Budha", "value": "budha"},
    {"text": "Hindu", "value": "hindu"},
    {"text": "Konghucu", "value": "konghucu"},
  ];
  bool _isEmployee = false;
  bool _isBusinessOwner = false;
  MemberRegistrationBloc _memberRegistrationBloc;
  MasterBloc _masterBloc;

  @override
  void initState() {
    super.initState();
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
    _masterBloc = BlocProvider.of<MasterBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _masterBloc.add(ResidenceStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UtilBloc, UtilState>(
          listener: (context, state) {
            if (state is SetDropdownState) {
              setState(() {
                switch (state.category) {
                  case 'statustinggal':
                    _statusResidence = state.item;
                    _payload.statusResidence = state.item;
                    break;
                  case 'pendidikanterakhir':
                    _lastEducation = state.item;
                    _payload.lastEducation = state.item;
                    break;
                  case 'maritalstatus':
                    _marital = state.item;
                    _payload.maritalStatus = state.item;
                    break;
                  case 'jeniskelamin':
                    _gender = state.item;
                    _payload.gender = state.item;
                    break;
                  case 'religion':
                    _religion = state.item;
                    _payload.religion = state.item;
                    break;
                  case 'heirs':
                    _heir = state.item;
                    _payload.heirRelation = state.item;
                    break;
                }
              });
            }
          },
        ),
        BlocListener<MasterBloc, MasterState>(
          listener: (context, state) {
            if (state is GetResidenceStatusSuccessState) {
              var residenceStatus =
                  JsonDecoder().convert(jsonEncode(state.data.data));
              _statusResidences = residenceStatus;
              _masterBloc.add(LastEducationEvent());
            } else if (state is GetResidenceStatusFailedState) {
              EasyLoading.dismiss();
            } else if (state is GetLastEducationSuccessState) {
              var lastEducation =
                  JsonDecoder().convert(jsonEncode(state.data.data));
              _lastEducations = lastEducation;
              EasyLoading.dismiss();
            } else if (state is GetLastEducationFailedState) {
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
                    child: CustomText(text: 'Data Personal', fontSize: 20),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Nama',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Nama harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.fullName = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'No. KTP',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isNumber: true,
                    maxLength: 16,
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'No. KTP harus di isi!';
                      }
                      if (value.length != 16) {
                        return 'No. KTP harus 16 digit!';
                      }
                      if (value.length > 16) {
                        return 'No. KTP harus 16 digit';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.nik = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Tempat lahir',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Tempat lahir harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.birthPlace = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Tanggal lahir',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppUtil().hideKeyboard(context);
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1960, 1, 1),
                          maxTime: DateTime.now(), onConfirm: (date) {
                        var birthDate = DateFormat('yyyy-MM-dd').format(date);
                        _birthDate.text = birthDate.toString();
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    child: Container(
                      color: Colors.white,
                      child: IgnorePointer(
                        child: CustomTextFieldForm(
                          controller: _birthDate,
                          keyboardType: TextInputType.name,
                          isReadOnly: true,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Tanggal lahir harus di isi!';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _payload.birthDate = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Alamat sesuai KTP',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Alamat sesuai ktp harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.addressKtp = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Alamat sesuai domisili',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Alamat sesuai domisili harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.addressDomicile = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Email',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.emailAddress,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Email harus di isi!';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Email harus sesuai!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.email = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'No. Whatsapp',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    isNumber: true,
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'No. Whatsapp harus di isi!';
                      }
                      if (value.length < 8) {
                        return 'No. Whatsapp minimal 8 karakter';
                      }
                      if (value.length > 16) {
                        return 'Maksimal No Whatsapp adalah 16 karakter';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.whatsappNumber = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Status Perkawinan',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomDropdownForm(
                    itemValue: _marital,
                    itemData: _maritals,
                    idKey: 'value',
                    nameKey: 'text',
                    category: 'maritalstatus',
                    hint: 'Status Perkawinan',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Jenis Kelamin',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomDropdownForm(
                    itemValue: _gender,
                    itemData: _genders,
                    idKey: 'value',
                    nameKey: 'text',
                    category: 'jeniskelamin',
                    hint: 'Jenis kelamin',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Agama',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomDropdownForm(
                    itemValue: _religion,
                    itemData: _religions,
                    idKey: 'value',
                    nameKey: 'text',
                    category: 'religion',
                    hint: 'Agama',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Status tempat tinggal',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomDropdownForm(
                    itemValue: _statusResidence,
                    itemData: _statusResidences,
                    idKey: 'value',
                    nameKey: 'value',
                    category: 'statustinggal',
                    hint: 'Pilih status tempat tinggal',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Pendidikan terakhir',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomDropdownForm(
                    itemValue: _lastEducation,
                    itemData: _lastEducations,
                    idKey: 'value',
                    nameKey: 'value',
                    category: 'pendidikanterakhir',
                    hint: 'Pilih pendidikan terakhir',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Jumlah tanggungan',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isNumber: true,
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Jumlah tanggungan harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.numberOfDependents = int.parse(value);
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Nama ibu kandung',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Nama ibu kandung harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.mothersName = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Nama ahli waris',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.name,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    isAll: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Nama ahli waris harus di isi!';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _payload.heirName = value;
                    },
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Hubungan ahli waris',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  CustomDropdownForm(
                    itemValue: _heir,
                    itemData: _heirs,
                    idKey: 'value',
                    nameKey: 'text',
                    category: 'heirs',
                    hint: 'Pilih ahli waris',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  CustomText(
                    text: 'Pekerjaan',
                    color: AppUtil().parseHexColor(CustomColors.NOBEL),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEmployee = true;
                              _isBusinessOwner = false;
                              _payload.jobType = 'employee';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppUtil().parseHexColor(
                                    CustomColors.GRANNY_SMITH_APPLE),
                              ),
                              color: _isEmployee
                                  ? AppUtil().parseHexColor(
                                      CustomColors.GRANNY_SMITH_APPLE)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: _screen.widthDefault(context) / 50,
                                vertical: _screen.heightDefault(context) / 70),
                            child: Text(
                              'Karyawan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _isEmployee
                                      ? Colors.white
                                      : AppUtil().parseHexColor(
                                          CustomColors.GRANNY_SMITH_APPLE),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: _screen.widthDefault(context) / 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isBusinessOwner = true;
                              _isEmployee = false;
                              _payload.jobType = 'business-owner';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppUtil().parseHexColor(
                                    CustomColors.GRANNY_SMITH_APPLE),
                              ),
                              color: _isBusinessOwner
                                  ? AppUtil().parseHexColor(
                                      CustomColors.GRANNY_SMITH_APPLE)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: _screen.widthDefault(context) / 50,
                                vertical: _screen.heightDefault(context) / 70),
                            child: Text(
                              'Bisnis Owner',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _isBusinessOwner
                                      ? Colors.white
                                      : AppUtil().parseHexColor(
                                          CustomColors.GRANNY_SMITH_APPLE),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButtonRaised(
                        title: 'Lanjut',
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            log('validate');
                            _formKey.currentState.save();
                            if (_statusResidence == null) {
                              AppUtil.showToast("Pilih status tempat tinggal");
                            } else if (_lastEducation == null) {
                              AppUtil.showToast("Pilih pendidikan terakhir");
                            } else if ((_isEmployee == false &&
                                _isBusinessOwner == false)) {
                              AppUtil.showToast("Pilih pekerjaan");
                            } else {
                              EasyLoading.show(
                                status: 'Loading...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              _memberRegistrationBloc.add(
                                  InitRegistrationMemberEvent(
                                      payload: _payload));
                            }
                          }
                        },
                        isCompleted: true,
                      ),
                    ],
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
