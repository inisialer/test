import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';

class CustomContainerStatus extends StatelessWidget {
  final String status;

  CustomContainerStatus({Key key, this.status}) : super(key: key);

  final _screen = ScreenUtil();

  var waiting = [
    "waiting",
    "waiting-confirmation",
    "waiting-paid",
    "waiting-payment"
  ];
  var success = ["success", "done", "success", "closed"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppUtil().parseHexColor(success.contains(status)
              ? CustomColors.GRANNY_SMITH_APPLE
              : (waiting.contains(status))
                  ? CustomColors.SWEET_CORN
                  :  CustomColors.CINNABAR),
          borderRadius: BorderRadius.circular(35)),
      padding: EdgeInsets.only(
          left: _screen.widthDefault(context) / 24,
          right: _screen.widthDefault(context) / 40,
          top: _screen.heightDefault(context) / 100,
          bottom: _screen.heightDefault(context) / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            (success.contains(status))
                ? 'Pembayaran Telah Diterima'
                : (status == 'failed')
                    ? 'Pembayaran Gagal'
                    : (status == 'expired')
                        ? 'Pembayaran Kedaluwarsa'
                        : (status == 'pending')
                            ? 'Pembayaran Pending'
                            : 'Menuggu Pembayaran',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
          ),
          Image.asset(
            (success.contains(status))
                ? 'assets/icon/ic_transaction_success.png'
                : (status == 'failed')
                    ? 'assets/icon/ic_transaction_failed.png'
                    : (status == 'expired')
                        ? 'assets/icon/ic_transaction_failed.png'
                        : (waiting.contains(status))
                            ? 'assets/icon/ic_transaction_pending.png'
                            : (status == 'pending')
                                ? 'assets/icon/ic_transaction_pending.png'
                                : 'assets/icon/ic_transaction_failed.png',
            width: 35,
            height: 35,
          )
        ],
      ),
    );
  }
}
