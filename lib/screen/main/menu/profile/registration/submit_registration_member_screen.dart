import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SubmitRegistrationMemberScreen extends StatefulWidget {
  const SubmitRegistrationMemberScreen({Key key}) : super(key: key);

  @override
  _FifthRegistrationEmployeeScreeState createState() =>
      _FifthRegistrationEmployeeScreeState();
}

class _FifthRegistrationEmployeeScreeState
    extends State<SubmitRegistrationMemberScreen> {
  final _screen = ScreenUtil();
  bool _isChecked = false;
  MemberRegistrationBloc _memberRegistrationBloc;

  @override
  void initState() {
    super.initState();
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: _screen.heightDefault(context) / 40),
        Center(
          child: CustomText(text: 'Halaman Pernyataan', fontSize: 20),
        ),
        SizedBox(height: _screen.heightDefault(context) / 40),
        Text(
          'Dengan Ini Saya Menyatakan:\n\n'
          'Bersedia memenuhi semua ketentuan yang tertera dalam anggaran dasar, anggaran rumah tangga, peraturan khusus dan kebijakan-kebijakan lainnya yang terdapat di Koperasi Al Hikmah Syariah.\n\n'
          'Seluruh data formulir wajib diisi dengan lengkap dan benar.\n\nSimpanan pokok sebesar Rp.100.000,00\n'
          'Simpanan Wajib sebesar Rp.25.000,00\n'
          'Dapat disetor langsung ke Koperasi Al Hikmah Syariah atau transfer bank melalui:\n\n',
          style: TextStyle(
              color: AppUtil().parseHexColor(CustomColors.MORTAR),
              fontSize: 16),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: AppUtil().parseHexColor(CustomColors.MORTAR),
                fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: '-\t'),
              TextSpan(
                  text: 'Permata Bank Syariah ',
                  style: TextStyle(
                      color: AppUtil()
                          .parseHexColor(CustomColors.GRANNY_SMITH_APPLE))),
              TextSpan(text: 'Cabang Tanah Abang a/n '),
              TextSpan(
                  text: 'Koperasi Al Hikmah Syariah no. rek 001801002362302',
                  style: TextStyle(
                      color: AppUtil()
                          .parseHexColor(CustomColors.GRANNY_SMITH_APPLE))),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: AppUtil().parseHexColor(CustomColors.MORTAR),
                fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: '-\t'),
              TextSpan(text: 'Bukti transfer dapat di emailkan ke alamat : '),
              TextSpan(
                  text: 'admin@alhikmahsyariah.com',
                  style: TextStyle(
                      color: AppUtil()
                          .parseHexColor(CustomColors.GRANNY_SMITH_APPLE))),
              TextSpan(
                  text:
                      ', bagian admin keanggotaan dengan menyertakan formulir pendaftaran\n'),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Checkbox(
                value: _isChecked,
                activeColor:
                    AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                onChanged: (bool value) {
                  setState(() {
                    _isChecked = value;
                  });
                }),
            Expanded(
                child: Text(
              'Saya Setuju dengan syarat dan ketentuan yang berlaku.',
              style: TextStyle(
                  color: AppUtil().parseHexColor(CustomColors.MORTAR)),
            ))
          ],
        ),
        SizedBox(height: _screen.heightDefault(context) / 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomButtonRaised(
              title: 'Lanjut',
              onTap: () {
                EasyLoading.show(
                  status: 'Loading...',
                  maskType: EasyLoadingMaskType.black,
                );
                _memberRegistrationBloc.add(SubmitRegistrationMemberEvent());
              },
              isCompleted: _isChecked)
        ])
      ],
    );
  }
}
