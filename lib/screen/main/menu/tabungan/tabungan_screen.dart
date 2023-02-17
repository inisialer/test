import 'package:alhikmah_app/bloc/tabungan_list/tabungan_list_bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../widget/custom_appbar_detail.dart';

class TabunganScreen extends StatefulWidget {
  @override
  State<TabunganScreen> createState() => _TabunganScreenState();
}

class _TabunganScreenState extends State<TabunganScreen> {
  final _screen = ScreenUtil();
  TabunganListBloc tabunganListBloc = TabunganListBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabunganListBloc.add(TabunganListGet());
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
        title: "Tabungan",
        isLeadingShow: true,
        body: Container(
          margin: EdgeInsets.only(
              left: _screen.widthDefault(context) / 20,
              right: _screen.widthDefault(context) / 20,
              top: _screen.heightDefault(context) / 20),
          child: BlocConsumer<TabunganListBloc, TabunganListState>(
            bloc: tabunganListBloc,
            listener: (context, state) {
              // TODO: implement listener
              if (state is TabunganListInitial) {
                EasyLoading.show(
                  status: 'Loading...',
                  maskType: EasyLoadingMaskType.black,
                );
              }
              if (state is TabunganListLoaded) {
                EasyLoading.dismiss();
              }
            },
            builder: (context, state) {
              if (state is TabunganListLoaded) if (state
                      .tabunganListModel.data.length >
                  0) {
                return ListView.builder(
                    itemCount: state.tabunganListModel.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(bottom: 28),
                          padding: EdgeInsets.only(
                              top: 28, bottom: 28, left: 23, right: 23),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Images.INFO_BAR),
                                fit: BoxFit.cover),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.tabunganListModel.data[index]
                                                .savingType ==
                                            "initial"
                                        ? "Setoran Awal"
                                        : state.tabunganListModel.data[index]
                                                    .savingType ==
                                                "recurring"
                                            ? "Setoran Rutin"
                                            : "Sisa Hasil Usaha",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppUtil().parseHexColor(
                                            CustomColors.GRANNY_SMITH_APPLE),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                      AppUtil().formattedMoneyIDR(state
                                          .tabunganListModel
                                          .data[index]
                                          .balance),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppUtil().parseHexColor(
                                              CustomColors.MORTAR),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: CustomButtonRaised(
                                      title: 'Lihat',
                                      isCompleted: true,
                                      onTap: () {
                                        if (state.tabunganListModel.data[index]
                                                .savingType ==
                                            "initial") {
                                          Navigator.pushNamed(
                                              context, '/setoran_awal_screen');
                                        } else if (state.tabunganListModel
                                                .data[index].savingType ==
                                            "recurring") {
                                          Navigator.pushNamed(
                                              context, '/setoran_rutin_screen');
                                        } else if (state.tabunganListModel
                                                .data[index].savingType ==
                                            "shu") {
                                          Navigator.pushNamed(
                                              context, '/setoran_shu_screen');
                                        } else {}
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ));
                    });
              } else {
                return Container(
                  child: Center(
                    child: Text(
                      "Belum ada transaksi.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                );
              }
              else
                return Container(
                  child: Center(
                    child: Text(
                      "Belum ada transaksi.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                );
            },
          ),
        ));
  }
}
