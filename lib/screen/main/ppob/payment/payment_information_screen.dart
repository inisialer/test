import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PaymentInformationScreen extends StatefulWidget {
  const PaymentInformationScreen({Key key}) : super(key: key);

  @override
  _PaymentInformationScreenState createState() =>
      _PaymentInformationScreenState();
}

class _PaymentInformationScreenState extends State<PaymentInformationScreen> {
  final _screen = ScreenUtil();
  UserBloc _userBloc;
  PaymentBloc _paymentBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    PaymentInformationArguments args =
        ModalRoute.of(context).settings.arguments;

    return CustomAppBarDetail(
      title: (args.status == 'success')
          ? 'Transaksi Berhasil'
          : (args.status == 'failed')
              ? 'Transaksi Gagal'
              : (args.status == 'pending')
                  ? 'Transaksi Pending'
                  : 'Transaksi Tertunda',
      isLeadingShow: false,
      body: InkWell(
        onTap: () {
          if (args.fromMenu == 'home') {
            EasyLoading.show(
              status: 'Loading...',
              maskType: EasyLoadingMaskType.black,
            );
            _userBloc.add(BalanceEvent(state: 'home'));
            MyNavigator.goBackToMain(context);
          } else if (args.fromMenu == 'history') {
            EasyLoading.show(
              status: 'Loading...',
              maskType: EasyLoadingMaskType.black,
            );
            _paymentBloc.add(HistoryTransactionEvent(
                startDate: '',
                endDate: '',
                sortBy: 'desc',
                page: 1,
                perPage: 10));
            MyNavigator.goBackToMain(context);
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    (args.status == 'success')
                        ? 'assets/icon/ic_transaction_success.png'
                        : (args.status == 'failed')
                            ? 'assets/icon/ic_transaction_failed.png'
                            : 'assets/icon/ic_transaction_pending.png',
                    height: _screen.heightDefault(context) / 8,
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 50),
                  Text(
                    (args.status == 'success')
                        ? 'Alhamdulillah\nTransaksi Berhasil'
                        : (args.status == 'failed')
                            ? 'Afwan\nTransaksi Gagal'
                            : (args.status == 'pending')
                                ? 'Afwan\nTransaksi Pending'
                                : 'Afwan\nTransaksi Tertunda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: _screen.heightDefault(context) / 30),
                child: Text(
                  'Ketuk Untuk Melanjutkan',
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

class PaymentInformationArguments {
  final String status;
  final String fromMenu;

  PaymentInformationArguments(this.status, this.fromMenu);
}
