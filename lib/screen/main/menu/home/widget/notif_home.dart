import 'package:alhikmah_app/model/memberregistration/registration_status_model.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/registration_status/_bloc.dart';
import '../../../../../data/constants.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/screen_util.dart';
import '../../../../../widget/custom_button_outline.dart';
import '../../../../../widget/custom_button_raised.dart';
import '../../tabungan/bayar_setoran_awal_screen.dart';

class NotifHome extends StatefulWidget {
  final RegistrationStatusModel registrationStatusModel;

  NotifHome({this.registrationStatusModel});
  @override
  State<NotifHome> createState() => _NotifHomeState();
}

class _NotifHomeState extends State<NotifHome> {
  final _screen = ScreenUtil();
  RegistrationStatusBloc registrationStatusBloc = RegistrationStatusBloc();

  @override
  void initState() {
    registrationStatusBloc.add(GetRegistrationStatus());

    super.initState();
  }

  Widget pengajuanDitolak() {
    return Container(
      height: 90,
      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
      decoration: BoxDecoration(
        color: Color(0xffFFCECE),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      child: Image.asset(
                        'assets/icon/ic_clock_alert.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Pengajuan ditolak',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Mohon maaf kami belum bisa menyetujui pengajuan Anggota Koperasi. Ajukan kembali dalam 14 hari.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget pengajuanDalamProses() {
    return Container(
      height: 90,
      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
      decoration: BoxDecoration(
        color: Color(0xffFEFFCF),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      child: Image.asset(
                        'assets/icon/ic_clock.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Pengajuan dalam proses',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Pengajuan Anggota Koperasi dalam proses, kami sedang memverifikasi data anda.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget daftarYuk() {
    return Container(
      height: 90,
      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
      decoration: BoxDecoration(
        color: Color(0xff79ECFC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Anggota Koperasi',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Daftar anggota koperasi untuk mendapatkan keuntungan lebih.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(_screen.widthDefault(context) / 65),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        child: CustomButtonOutline(
                          title: 'Daftar Yuk',
                          onTap: () {
                            MyNavigator.goToProfileRegistrationMember(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget pengajuanDiterima() {
    return Container(
      height: 90,
      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
      decoration: BoxDecoration(
        color: Color(0xffCEFFE8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengajuan disetujui',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Mohon melakukan setoran awal untuk mengaktifkan keanggotaan.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(_screen.widthDefault(context) / 65),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        child: CustomButtonOutline(
                          title: 'Setoran Awal',
                          onTap: () async {
                            Navigator.pushNamed(
                                context, '/bayar_setoran_awal_screen',
                                arguments: BayarSetoranArgs());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget decideWidget(RegistrationStatusModel registrationStatusModel) {
    switch (registrationStatusModel.data.registrationStatus) {
      case 'form-filling':
        return daftarYuk();
        break;
      case 'approved':
        return pengajuanDiterima();
        break;
      case 'submitted':
        return pengajuanDalamProses();
        break;
      case 'done':
        return Container();
        break;
      case 'rejected':
        return pengajuanDitolak();
      default:
        return daftarYuk();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationStatusBloc, RegistrationStatusState>(
      bloc: registrationStatusBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is RegistrationStatusLoaded) {
          return decideWidget(state.registrationStatusModel);
        } else if (state is RegistrationStatusError) {
          return daftarYuk();
        } else {
          return Container();
        }
      },
    );
  }
}
