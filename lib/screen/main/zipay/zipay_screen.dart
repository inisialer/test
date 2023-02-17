import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/bloc/zipay/bloc.dart';
import 'package:alhikmah_app/screen/main/zipay/widget/card_zipay.dart';
import 'package:alhikmah_app/screen/main/zipay/widget/list_feature.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ZipayScreen extends StatefulWidget {
  const ZipayScreen({Key key}) : super(key: key);

  @override
  State<ZipayScreen> createState() => _ZipayScreenState();
}

class _ZipayScreenState extends State<ZipayScreen> {
  UserBloc _userBloc;
  ZipayBloc _zipayBloc;
  int _money = 0;
  String _name = "-";

  List<Map<String, dynamic>> feature = [
    {
      "name": "Top Up",
      "desc" : "Top Up dengan berbagai metode",
      "image": "assets/icon/history_topup.png",
      "onclick": (BuildContext context){
        MyNavigator.gotToListVirtual(context);
      },
    },
    {
      "name": "Riwayat Transaksi",
      "desc" : "Lihat transaksi yang kamu lakukan",
      "image": "assets/icon/icon_history_transaction.png",
      "onclick": (BuildContext context){
        MyNavigator.goToHistoryZipay(context);
      },
    },
    {
      "name": "Tingkatkan Akun Zipay",
      "desc" : "Untuk limit saldo yang lebih besar",
      "image": "assets/icon/icon_upgrade_kyc.png",
      "onclick": (BuildContext context){
        MyNavigator.goUpgradeZipayIntro(context);
      },
    }
  ];

  ScreenUtil _screenUtil = ScreenUtil();

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(BalanceEvent());
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener(
            listener: (context, state) {
              if(state is GetBalanceSuccessState) {
                _money = state.data.data.balance;
                _userBloc.add(MeEvent());
              }else if(state is GetBalanceFailedState){
                EasyLoading.dismiss();
                AppUtil.showToast("Failed to get info");
                MyNavigator.goBackToMain(context);
              }else if(state is GetMeSuccessState){
                EasyLoading.dismiss();
              }else if(state is GetMeFailedState) {
                EasyLoading.dismiss();
                AppUtil.showToast("Failed to get info");
                MyNavigator.goBackToMain(context);
              }
            },
            bloc: _userBloc,
          ),
        ],
        child: CustomAppBarDetail(
          title: 'Zipay',
          background: Colors.white,
          withDecoration: false,
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  "assets/icon/icon_ask.png",
                  width: 30,
                ),
              ),
            )
          ],
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: _screenUtil.heightDefault(context),
            width: _screenUtil.widthDefault(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 BlocBuilder(
                   bloc: _userBloc,
                   builder: (context, state){
                     String money = AppUtil().formattedMoneyIDR(_money);
                     String name = _name;
                     if(state is GetMeSuccessState){
                       _name = state.data.data.firstName + " " + state.data.data.lastName;
                       name = _name;
                       money = AppUtil().formattedMoneyIDR(_money);
                     }
                     return  CardZipay(
                       name: name,
                       money: money,
                     );
                   },
                 ),
                  Container(
                    margin: EdgeInsets.only(top: _screenUtil.heightDefault(context)/ 15),
                    child: Column(
                      children: [
                        ...feature.map((e) => InkWell(
                          onTap: (){
                            e["onclick"](context);
                          },
                          child: ListFeature(
                            name: e["name"],
                            asset: e["image"],
                            description: e["desc"],
                          ),
                        )).toList(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
