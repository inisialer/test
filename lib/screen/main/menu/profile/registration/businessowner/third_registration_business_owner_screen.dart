import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/third_registration_business_owner_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/upload_document_member_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_button_upload_image.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ThirdRegistrationBusinessOwnerScreen extends StatefulWidget {
  const ThirdRegistrationBusinessOwnerScreen({Key key}) : super(key: key);

  @override
  _ThirdRegistrationBusinessOwnerScreenState createState() =>
      _ThirdRegistrationBusinessOwnerScreenState();
}

class _ThirdRegistrationBusinessOwnerScreenState
    extends State<ThirdRegistrationBusinessOwnerScreen> {
  final _screen = ScreenUtil();
  final _formKey = GlobalKey<FormState>();
  MemberRegistrationBloc _memberRegistrationBloc;
  ThirdRegistrationBusinessOwnerPayloadModel _payload =
      ThirdRegistrationBusinessOwnerPayloadModel();

  String _photoSelfie;
  String _photoKtp;
  String _photoNpwp;
  String _photoTempatUsaha;
  String _photoAktifitasUsaha;
  String _photoSuratIzinUsaha;
  String _photoKepemilikanTempat;

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
                    arguments: UploadDocumentArguments('npwp-photo'));
                if (results != null) {
                  setState(() {
                    _photoNpwp = results;
                    _payload.npwpPhoto = results;
                  });
                }
              },
              child: CustomButtonUploadImage(
                title: 'Foto NPWP',
                desc: 'Pastikan Tulisan Pada Foto Dapat Terbaca Dengan Jelas',
                isSuccess: _photoNpwp != null ? true : false,
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            GestureDetector(
              onTap: () async {
                var results = await Navigator.pushNamed(
                    context, '/upload-document',
                    arguments: UploadDocumentArguments('business-place-photo'));
                if (results != null) {
                  setState(() {
                    _photoTempatUsaha = results;
                    _payload.businessPlacePhoto = results;
                  });
                }
              },
              child: CustomButtonUploadImage(
                title: 'Foto Tempat Usaha',
                desc: 'Foto Tempat Usaha Anda Pada Tampak Depan',
                isSuccess: _photoTempatUsaha != null ? true : false,
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            GestureDetector(
              onTap: () async {
                var results = await Navigator.pushNamed(
                    context, '/upload-document',
                    arguments:
                        UploadDocumentArguments('business-activity-photo'));
                if (results != null) {
                  setState(() {
                    _photoAktifitasUsaha = results;
                    _payload.businessActivityPhoto = results;
                  });
                }
              },
              child: CustomButtonUploadImage(
                title: 'Foto Aktivitas Usaha',
                desc: 'Foto Aktivitas Usaha Saat Sedang Berlangsung',
                isSuccess: _photoAktifitasUsaha != null ? true : false,
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            GestureDetector(
              onTap: () async {
                var results = await Navigator.pushNamed(
                    context, '/upload-document',
                    arguments:
                        UploadDocumentArguments('business-license-photo'));
                if (results != null) {
                  setState(() {
                    _photoSuratIzinUsaha = results;
                    _payload.businessLicensePhoto = results;
                  });
                }
              },
              child: CustomButtonUploadImage(
                title: 'Foto Surat Izin Usaha',
                desc: 'Foto Surat Izin Usaha/Surat Keterangan Usaha Dari RT/RW',
                isSuccess: _photoSuratIzinUsaha != null ? true : false,
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            GestureDetector(
              onTap: () async {
                var results = await Navigator.pushNamed(
                    context, '/upload-document',
                    arguments:
                        UploadDocumentArguments('place-ownership-proof'));
                if (results != null) {
                  setState(() {
                    _photoKepemilikanTempat = results;
                    _payload.placeOwnershipProofPhoto = results;
                  });
                }
              },
              child: CustomButtonUploadImage(
                title: 'Foto Kepemilikan Tempat',
                desc: 'Foto Bukti Kepemilikan Usaha atau Kontrak Usaha Anda',
                isSuccess: _photoKepemilikanTempat != null ? true : false,
              ),
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
                    } else if (_photoNpwp == null) {
                      AppUtil.showToast("Foto npwp harus di isi");
                    } else if (_photoTempatUsaha == null) {
                      AppUtil.showToast("Foto tempat usaha harus di isi");
                    } else if (_photoAktifitasUsaha == null) {
                      AppUtil.showToast("Foto aktifitas usaha harus di isi");
                    } else if (_photoSuratIzinUsaha == null) {
                      AppUtil.showToast("Foto izin usaha harus di isi");
                    } else if (_photoKepemilikanTempat == null) {
                      AppUtil.showToast("Foto kepemilikan tempat harus di isi");
                    } else {
                      EasyLoading.show(
                        status: 'Loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      _memberRegistrationBloc.add(
                          ThirdRegistrationBusinessOwnerEvent(
                              payload: _payload));
                    }
                  }
                },
                isCompleted: true,
              )
            ])
          ],
        ),
      ),
    );
  }
}
