import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/bloc/zipay/bloc.dart';
import 'package:alhikmah_app/model/zipay/zipay_va_model.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../widget/custom_appbar_detail.dart';
import 'detail_virtual_bank.dart';

class ListTopUpBank extends StatefulWidget {
  const ListTopUpBank({Key key}) : super(key: key);

  @override
  State<ListTopUpBank> createState() => _ListTopUpBankState();
}

class _ListTopUpBankState extends State<ListTopUpBank> {
  ScreenUtil _screen = ScreenUtil();

  UserBloc userBloc;
  ZipayBloc zipayBloc;
  List<Data> va = [];

  int money = 0;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    zipayBloc = BlocProvider.of<ZipayBloc>(context);
    userBloc.add(BalanceEvent());
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
            if (state is GetBalanceSuccessState) {
              money = state.data.data.balance;
              zipayBloc.add(TransactionVAEvent());
            } else if (state is GetBalanceFailedState) {
              print(state);
            }
          },
          bloc: userBloc,
        ),
        BlocListener(
          listener: (context, state) {
            if (state is TransactionVASuccessState) {
              EasyLoading.dismiss();
              va = state.data.data;
            }
          },
          bloc: zipayBloc,
        ),
      ],
      child: CustomAppBarDetail(
          title: 'Top Up',
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  Container(
                    width: _screen.widthDefault(context),
                    child: Text(
                      "Saldo Zipay Anda",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 30, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/image/img_bank_zipay.png",
                          width: 80,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          "Zipay",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        BlocBuilder(
                            bloc: userBloc,
                            builder: (context, state) {
                              if (state is GetBalanceSuccessState) {
                                money = state.data.data.balance;
                              }
                              return Expanded(
                                  child: Text(
                                AppUtil().formattedMoneyIDR(money),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ));
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: _screen.widthDefault(context),
                    child: Text("Pilih Bank Provider Anda",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: BlocBuilder(
                      bloc: zipayBloc,
                      builder: (context, state) {
                        return Column(
                          children: [
                            ...va
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        MyNavigator.gotToDetailVirtual(context, ListVirtualBankArgs(data: e));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[200],
                                              offset: const Offset(
                                                0.0,
                                                1.0,
                                              ),
                                              blurRadius: 3.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        margin: EdgeInsets.only(top: 20),
                                        width: _screen.widthDefault(context),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/image/img_bank_maybank.png",
                                              width: 60,
                                              fit: BoxFit.fitWidth,
                                            ),
                                            Expanded(
                                                child: Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text(e.bankName),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()
                          ],
                        );
                      },
                    ),
                  ))
                ],
              ))),
    );
  }
}
