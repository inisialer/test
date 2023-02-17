import 'package:alhikmah_app/bloc/zipay/bloc.dart';
import 'package:alhikmah_app/model/zipay/zipay_history_model.dart';
import 'package:alhikmah_app/screen/main/zipay/widget/list_history_transaction.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../../util/app_util.dart';
import '../../../util/navigator.dart';
import '../../../widget/custom_appbar_detail.dart';

class RiwayatTransaksiScreen extends StatefulWidget {
  const RiwayatTransaksiScreen({Key key}) : super(key: key);

  @override
  State<RiwayatTransaksiScreen> createState() => _RiwayatTransaksiScreenState();
}

class _RiwayatTransaksiScreenState extends State<RiwayatTransaksiScreen> {
  ScreenUtil _screenUtil = new ScreenUtil();
  ZipayBloc _zipayBloc;

  DateFormat _format = DateFormat("M/d/yy");
  DateFormat _format2 = DateFormat("M/d/yy h:mm:ss aaa");


  @override
  void initState() {
    _zipayBloc = BlocProvider.of<ZipayBloc>(context);
    _zipayBloc.add(TransactionHistoryEvent());
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    super.initState();
  }

  int _compare(Data a, Data b) {
    return _format
        .parse(b.transactionDate).compareTo(_format.parse(a.transactionDate));
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
      title: 'Riwayat Transaksi',
      background: Colors.white,
      withDecoration: false,
      actions: [],
      body: MultiBlocListener(
        listeners: [
          BlocListener(
              bloc: _zipayBloc,
              listener: (context, state) {
                if (state is TransactionHistorySuccessState) {
                  EasyLoading.dismiss();
                } else if (state is TransactionHistoryFailedState) {
                  EasyLoading.dismiss();
                  AppUtil.showToast("Failed to get info");
                  MyNavigator.goBackToMain(context);
                }
              }),
        ],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: _screenUtil.widthDefault(context),
          height: _screenUtil.heightDefault(context),
          child: SingleChildScrollView(
            child: BlocBuilder(
              bloc: _zipayBloc,
              builder: (contex, state) {
                List<Data> data = [];
                if (state is TransactionHistorySuccessState) {
                  data = state.data.data;
                  data.sort(_compare);
                }
                print(data);
                return Column(
                  children: [
                    ...data
                        .asMap()
                        .map((key, value) {
                          bool withDate = true;
                          var date = _format2.parse(value.transactionDate);
                          if (key >= 1) {
                            if (_format.parse(value.transactionDate).compareTo(_format.parse(data[key - 1].transactionDate)) == 0) {
                              if(key - 1 == 0){
                                withDate = true;
                              }
                              withDate = false;
                            }
                          }
                          return MapEntry(
                              key,
                              ListHistoryTransaction(
                                time: DateFormat("hh:mm:ss aaa").format(date),
                                withDate: withDate,
                                status: value.status,
                                description: value.productName,
                                transactionDate: DateFormat("EEEE, dd MMMM yyyy").format(date),
                                amount: AppUtil().formattedMoneyIDR(
                                    int.parse(value.totalAmount)),
                              ));
                        })
                        .values
                        .toList()
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
