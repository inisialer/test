import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/third_registration_employee_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/upload_document_member_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_button_upload_image.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class ThirdRegistrationEmployeeScreen extends StatefulWidget {
  const ThirdRegistrationEmployeeScreen({Key key}) : super(key: key);

  @override
  _ThirdRegistrationEmployeeScreenState createState() =>
      _ThirdRegistrationEmployeeScreenState();
}

class _ThirdRegistrationEmployeeScreenState
    extends State<ThirdRegistrationEmployeeScreen> {
  final _screen = ScreenUtil();
  final _formKey = GlobalKey<FormState>();
  MemberRegistrationBloc _memberRegistrationBloc;

  ThirdRegistrationEmployeePayloadModel _payload =
      ThirdRegistrationEmployeePayloadModel();

  String _photoSelfie;
  String _photoKtp;
  String _photoSignature;

  TextEditingController _ktpBatas = TextEditingController();
  bool isValue = false;

  @override
  void initState() {
    super.initState();
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _screen.heightDefault(context) / 40),
            Center(
              child: CustomText(text: 'Dokumen', fontSize: 20),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            GestureDetector(
              onTap: () async {
                var results = await Navigator.pushNamed(
                    context, '/upload-document',
                    arguments: UploadDocumentArguments('selfie-photo'));
                if (results != null) {
                  setState(() {
                    _photoSelfie = results;
                    _payload.selfiePhoto = results;
                  });
                }
              },
              child: CustomButtonUploadImage(
                title: 'Foto Profil',
                desc: 'Ambil Foto di ruangan yang cukup cahaya',
                isSuccess: _photoSelfie != null ? true : false,
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            GestureDetector(
              onTap: () async {
                var results = await Navigator.pushNamed(
                    context, '/upload-document',
                    arguments: UploadDocumentArguments('ktp-photo'));
                if (results != null) {
                  setState(() {
                    _photoKtp = results;
                    _payload.ktpPhoto = results;
                  });
                }
              },
              child: CustomButtonUploadImage(
                title: 'Foto E-KTP',
                desc: 'Pastikan Tulisan Pada Foto Dapat Terbaca Dengan Jelas',
                isSuccess: _photoKtp != null ? true : false,
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            GestureDetector(
              onTap: () async {
                var results = await Navigator.pushNamed(
                    context, '/upload-document',
                    arguments: UploadDocumentArguments('signature-photo'));
                if (results != null) {
                  setState(() {
                    _photoSignature = results;
                    _payload.signaturePhoto = results;
                  });
                }
              },
              child: CustomButtonUploadImage(
                title: 'Foto Tanda Tangan',
                desc: 'Pastikan Tulisan Pada Foto Dapat Terbaca Dengan Jelas',
                isSuccess: _photoSignature != null ? true : false,
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomText(
              text: 'Masa Berlaku KTP',
              color: AppUtil().parseHexColor(CustomColors.NOBEL),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Checkbox(
                    value: isValue,
                    activeColor: AppUtil()
                        .parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                    onChanged: (bool value) {
                      setState(() {
                        isValue = value;
                      });

                      if (isValue == true) {
                        _payload.ktpValidityPeriod = "Seumur Hidup";
                      } else {
                        _payload.ktpValidityPeriod = _ktpBatas.text;
                      }
                    }),
                Expanded(
                    child: Text(
                  'Seumur Hidup',
                  style: TextStyle(
                      color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                ))
              ],
            ),
            isValue == false
                ? GestureDetector(
                    onTap: () {
                      AppUtil().hideKeyboard(context);
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1960, 1, 1),
                          maxTime: DateTime.now(), onConfirm: (date) {
                        var birthDate = DateFormat('yyyy-MM-dd').format(date);
                        _ktpBatas.text = birthDate.toString();
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    child: Container(
                      color: Colors.white,
                      child: IgnorePointer(
                        child: CustomTextFieldForm(
                          controller: _ktpBatas,
                          keyboardType: TextInputType.name,
                          isReadOnly: true,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Masa berlaku harus di isi!';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _payload.ktpValidityPeriod = value;
                          },
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomText(
              text: 'Kewarganegaraan',
              color: AppUtil().parseHexColor(CustomColors.NOBEL),
            ),
            CustomTextFieldForm(
              keyboardType: TextInputType.name,
              color: AppUtil().parseHexColor(CustomColors.MORTAR),
              isAll: true,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Kewarganegaraan harus di isi!';
                }
                return null;
              },
              onSaved: (String value) {
                _payload.nationality = value;
              },
            ),
            SizedBox(height: _screen.heightDefault(context) / 24),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomButtonRaised(
                  title: 'Lanjut',
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (_photoSelfie == null) {
                        AppUtil.showToast("Foto selfie harus di isi");
                      } else if (_photoKtp == null) {
                        AppUtil.showToast("Foto ktp harus di isi");
                      } else if (_photoSignature == null) {
                        AppUtil.showToast("Foto ttd harus di isi");
                      } else {
                        EasyLoading.show(
                          status: 'Loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        _memberRegistrationBloc.add(
                            ThirdRegistrationEmployeeEvent(payload: _payload));
                      }
                    }
                  },
                  isCompleted: true)
            ])
          ],
        ),
      ),
    );
  }
}
