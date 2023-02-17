import 'package:alhikmah_app/bloc/zipay/bloc.dart';
import 'package:alhikmah_app/screen/main/zipay/widget/list_feature.dart';
import 'package:alhikmah_app/screen/main/zipay/widget/modal_success.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../bloc/zipay/zipay_bloc.dart';
import '../../../util/navigator.dart';
import '../../../widget/custom_appbar_detail.dart';

class UpgradeZipayScreen extends StatefulWidget {
  const UpgradeZipayScreen({Key key}) : super(key: key);

  @override
  State<UpgradeZipayScreen> createState() => _UpgradeZipayScreenState();
}

class _UpgradeZipayScreenState extends State<UpgradeZipayScreen> {
  ScreenUtil _screenUtil = new ScreenUtil();
  ZipayBloc _zipayBloc;

  List<Map<String, dynamic>> feature = [
    {
      "name": "Limit saldo Zipay yang lebih besar",
      "desc": "Dapatkan limit saldo samapi dengan Rp 10.000.000 ",
      "image": "assets/icon/ic_main_wallet.png",
      "onclick": (BuildContext context) {},
    },
    {
      "name": "Penawaran yang menarik ",
      "desc":
          "Kami akan selalu memberikan penawaran menarik untuk anda setiap hari",
      "image": "assets/icon/ic_baseline-discount.png",
      "onclick": (BuildContext context) {},
    },
    {
      "name": "Keuntungan lainnya",
      "desc":
          "Dapatkan kemudahan dalam bertransaksi dan mempersingkat waktu dalam kegiatan kamu",
      "image": "assets/icon/bx_gift.png",
      "onclick": (BuildContext context) {},
    }
  ];
  int _result;

  @override
  void initState() {
    _zipayBloc = BlocProvider.of<ZipayBloc>(context);
    _zipayBloc.add(StatusKYCEvent());
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _zipayBloc,
      listener: (context, state) {
        if (state is StatusKYCSuccessState) {
          _result = state.data.data.result;
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: ModalSuccess(
                    onClick: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName("/zipay/homepage"));
                    },
                    withButton: true,
                    buttonText: "Kembali ke Halaman Zipay",
                    title: _result == 1
                        ? "Zipay Telah Ditingkatkan"
                        : "Zipay Dalam Proses Upgrade",
                    description: _result == 1
                        ? "Akun zipay anda telah ditingkatkan."
                        : "Akun Zipay anda dalam proses peningkatan",
                    width: _screenUtil.widthDefault(context) * 0.8,
                  ),
                );
              });
          EasyLoading.dismiss();
        } else if (state is StatusKYCFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: CustomAppBarDetail(
          title: 'Tingkatkan Akun Zipaymu',
          background: Colors.white,
          withDecoration: false,
          actions: [],
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            width: _screenUtil.widthDefault(context),
            height: _screenUtil.heightDefault(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/image/logo_zipay.png",
                      height: 60,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: _screenUtil.heightDefault(context) / 15),
                      width: _screenUtil.widthDefault(context) * 0.7,
                      child: Text(
                        "Tingkatkan Akun anda, dan kamu akan mendapatkan akses untuk",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: _screenUtil.heightDefault(context) / 15),
                    child: Column(
                      children: [
                        ...feature
                            .map((e) => ListFeature(
                                  name: e["name"],
                                  asset: e["image"],
                                  description: e["desc"],
                                ))
                            .toList(),
                        Container(
                          width: _screenUtil.widthDefault(context),
                          margin: EdgeInsets.only(
                              top: _screenUtil.heightDefault(context) / 20),
                          child: CustomButtonRaised(
                            title: "Tingkatkan",
                            isCompleted: true,
                            onTap: () {
                              if (_result < 3) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: ModalSuccess(
                                          onClick: () {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    "/zipay/homepage"));
                                          },
                                          withButton: true,
                                          buttonText:
                                              "Kembali ke Halaman Zipay",
                                          title: _result == 1
                                              ? "Zipay Telah Ditingkatkan"
                                              : "Zipay Dalam Proses Upgrade",
                                          description: _result == 1
                                              ? "Akun zipay anda telah ditingkatkan."
                                              : "Akun Zipay anda dalam proses peningkatan",
                                          width: _screenUtil
                                                  .widthDefault(context) *
                                              0.8,
                                        ),
                                      );
                                    });
                              } else {
                                MyNavigator.goUpgradeZipayForm(context);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
