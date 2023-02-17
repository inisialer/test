import 'package:alhikmah_app/bloc/zipay/bloc.dart';
import 'package:alhikmah_app/model/zipay/zipay_update_kyc_model.dart';
import 'package:alhikmah_app/screen/main/zipay/widget/modal_success.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../widget/custom_button_upload_image.dart';

class FormUpgradeZipayScreen extends StatefulWidget {
  const FormUpgradeZipayScreen({Key key}) : super(key: key);

  @override
  State<FormUpgradeZipayScreen> createState() => _FormUpgradeZipayScreenState();
}

class _FormUpgradeZipayScreenState extends State<FormUpgradeZipayScreen> {
  ScreenUtil _screen = ScreenUtil();
  ZipayBloc _zipayBloc;

  String _idCard;
  String selfie;

  Map<String, String> _payload = {};

  @override
  void initState() {
    _zipayBloc = BlocProvider.of<ZipayBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is UpdateKYCSuccessState) {
          EasyLoading.dismiss();
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: ModalSuccess(
                    onClick: (){
                      Navigator.popUntil(context, ModalRoute.withName("/zipay/homepage") );
                    },
                    withButton: true,
                    buttonText: "Kembali ke Halaman Zipay",
                    title: "Data Berhasil Disimpan",
                    description: "Pengajuan Tingkatkan akun Zipay berhasil diproses. Silahkan menunggu konfirmasi kami atas pengajuan kamu.",
                    width: _screen.widthDefault(context) * 0.8,
                  ),
                );
              });
        } else if (state is UpdateKYCFailedState) {
          EasyLoading.dismiss();
        }
      },
      bloc: _zipayBloc,
      child: CustomAppBarDetail(
        title: 'Tingkatkan Akun Zipay',
        body: Container(
          width: _screen.widthDefault(context),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  var results = await Navigator.pushNamed(
                    context,
                    '/upgrade/upload/upgrade',
                  );
                  if (results != null) {
                    setState(() {
                      _idCard = results;
                      _payload["id_card"] = _idCard;
                    });
                  }
                },
                child: CustomButtonUploadImage(
                  title: 'Foto KTP',
                  desc: 'Ambil Foto di ruangan yang cukup cahaya',
                  isSuccess: _idCard != null ? true : false,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: GestureDetector(
                  onTap: () async {
                    var results = await Navigator.pushNamed(
                      context,
                      '/upgrade/upload/upgrade',
                    );
                    if (results != null) {
                      setState(() {
                        selfie = results;
                        _payload["selfie"] = selfie;
                      });
                    }
                  },
                  child: CustomButtonUploadImage(
                    title: 'Foto Selfie',
                    desc: 'Ambil Foto di ruangan yang cukup cahaya',
                    isSuccess: selfie != null ? true : false,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: _screen.widthDefault(context),
                child: CustomButtonRaised(
                  onTap: () {
                    _zipayBloc
                        .add(UpdateKYCEvent(idCard: _idCard, selfie: selfie));
                    EasyLoading.show(
                      status: 'Loading...',
                      maskType: EasyLoadingMaskType.black,
                    );
                  },
                  isCompleted: _idCard != null && selfie != null,
                  title: 'Tingkatkan',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
