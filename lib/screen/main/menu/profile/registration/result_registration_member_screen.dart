import 'package:alhikmah_app/bloc/registration_status/_bloc.dart';
import 'package:alhikmah_app/bloc/registration_status/registration_status_bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../service/member_registration_service.dart';
import '../../../../../widget/custom_button_raised.dart';

class ResultRegistrationMemberScreen extends StatefulWidget {
  const ResultRegistrationMemberScreen({Key key}) : super(key: key);

  @override
  _ResultRegistrationMemberScreenState createState() =>
      _ResultRegistrationMemberScreenState();
}

class _ResultRegistrationMemberScreenState
    extends State<ResultRegistrationMemberScreen> {
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    ResultRegistrationMemberArguments args =
        ModalRoute.of(context).settings.arguments;

    return CustomAppBarDetail(
      title: "Status Pengajuan",
      isLeadingShow: true,
      body: InkWell(
        onTap: () {
          MyNavigator.goBackToMain(context);
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    args.status == 'approved'
                        ? 'assets/icon/ic_transaction_success.png'
                        : args.status == 'rejected'
                            ? 'assets/icon/ic_transaction_failed.png'
                            : 'assets/icon/ic_transaction_pending.png',
                    height: _screen.heightDefault(context) / 8,
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 50),
                  Text(
                    args.status == 'approved'
                        ? 'Pengajuan disetujui'
                        : args.status == 'rejected'
                            ? 'Pengajuan ditolak'
                            : 'Pengajuan dalam proses',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 50),
                  Text(
                    args.status == 'approved'
                        ? 'Pengajuan anggota koperasi disetujui. Mohon lakukan setoran awal untuk mengaktifkan keuntungan anggota koperasi.'
                        : args.status == 'rejected'
                            ? 'Mohon maaf pengajuan anggota koperasi anda ditolak.'
                            : 'Pengajuan anggota koperasi dalam proses',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 50),
                  args.status == 'rejected'
                      ? CustomButtonRaised(
                          isCompleted: true,
                          onTap: () async {
                            EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            await MemberRegistrationService()
                                .resubmitRegistrationMember();
                            await EasyLoading.dismiss();
                            MyNavigator.goToProfileRegistrationMember(context);
                          },
                          title: 'Ajukan Kembali',
                        )
                      : args.status == 'approved'
                          ? CustomButtonRaised(
                              isCompleted: true,
                              onTap: () {},
                              title: 'Bayar Setoran Awal',
                            )
                          : Container()
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: _screen.heightDefault(context) / 30),
                child: Text(
                  args.status == 'approved'
                      ? 'Silahkan lanjutkan transaksi'
                      : args.status == 'rejected'
                          ? 'Ada data yang tidak sesuai'
                          : 'Dokumen Anda Akan \nDiverifikasi Dalam 1x24 Jam',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResultRegistrationMemberArguments {
  final String status;
  final String reason;

  ResultRegistrationMemberArguments(this.status, this.reason);
}
