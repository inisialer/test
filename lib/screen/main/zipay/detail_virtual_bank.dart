import 'package:alhikmah_app/model/zipay/zipay_va_model.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../../data/constants.dart';
import '../../../util/app_util.dart';
import '../../../widget/custom_appbar_detail.dart';
import '../../../widget/custom_container_rounded.dart';

part 'package:alhikmah_app/screen/main/zipay/widget/item_method_bank.dart';

class ListVirtualBankScreen extends StatefulWidget {
  const ListVirtualBankScreen({Key key}) : super(key: key);

  @override
  State<ListVirtualBankScreen> createState() => _ListVirtualBankScreenState();
}

class _ListVirtualBankScreenState extends State<ListVirtualBankScreen> {

  ScreenUtil _screen = ScreenUtil();
  Data _dataBank;

  bool _isVisibleMobile = false;
  bool _isVisibleAtm = false;
  bool _isVisibleInternet = false;

  @override
  Widget build(BuildContext context) {
    ListVirtualBankArgs args = ModalRoute.of(context).settings.arguments;
    _dataBank = args.data;
    return CustomAppBarDetail(
      title: 'Cara Pembayaran',
      body: Padding(
        padding: EdgeInsets.only(
            top: _screen.heightDefault(context) / 100,
            left: _screen.widthDefault(context) / 16,
            right: _screen.widthDefault(context) / 16),
        child: ListView(
          children: [
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomContainerRounded(
              paddingVertical: 0,
              widget: Column(
                children: [
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  // Image.network(
                  //   _dataBank?.bankLogo ?? '',
                  //   width: _screen.widthDefault(context) / 5,
                  //   height: _screen.heightDefault(context) / 18,
                  // ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  Text(
                    'Nomor ${_dataBank?.bankName} Virtual Account',
                    style: TextStyle(
                        fontSize: 12,
                        color:
                        AppUtil().parseHexColor(CustomColors.SILVER),
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  Text(
                    _dataBank.vacctNo ?? '',
                    style: TextStyle(
                        color: AppUtil().parseHexColor(
                            CustomColors.GRANNY_SMITH_APPLE),
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 64),
                  MaterialButton(
                    onPressed: () {
                      FlutterClipboard.copy(_dataBank.vacctNo
                          .toString()
                          .replaceAll(RegExp(r'\s+'), ''))
                          .then((value) => AppUtil.showToast(
                          'Virtual Account di salin ke papan klik'));
                    },
                    child: Text(
                      'Salin',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppUtil().parseHexColor(
                              CustomColors.GRANNY_SMITH_APPLE)),
                    ),
                    color: Colors.white,
                    disabledColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: AppUtil().parseHexColor(
                              CustomColors.GRANNY_SMITH_APPLE)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                ],
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            CustomContainerRounded(
              widget: GestureDetector(
                onTap: () {
                  setState(() {
                    _isVisibleMobile = !_isVisibleMobile;
                  });
                },
                child: _ItemMethodBank(
                  isVisible: _isVisibleMobile,
                  title: 'Mobile Banking',
                  desc:
                  '1. Buka Aplikasi ${_dataBank.bankName} MOBILE\n2. Buka BELI > TOP UP > ZIPAY\n3. Masukan ${_dataBank.vacctNo}\n4. Masukan nominal top up\n5. Ikuti instrusksi untuk melanjutkan',
                ),
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 100),
            CustomContainerRounded(
              widget: GestureDetector(
                onTap: () {
                  setState(() {
                    _isVisibleInternet = !_isVisibleInternet;
                  });
                },
                child: _ItemMethodBank(
                  isVisible: _isVisibleInternet,
                  title: 'Internet Banking',
                  desc:
                  '1. Buka Aplikasi ${_dataBank.bankName} MOBILE\n2. Buka BELI > TOP UP > ZIPAY\n3. Masukan ${_dataBank.vacctNo}\n4. Masukan nominal top up\n5. Ikuti instrusksi untuk melanjutkan',
                ),
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 100),
            CustomContainerRounded(
              widget: GestureDetector(
                onTap: () {
                  setState(() {
                    _isVisibleAtm = !_isVisibleAtm;
                  });
                },
                child: _ItemMethodBank(
                  isVisible: _isVisibleAtm,
                  title: 'ATM',
                  desc:
                  '1. Buka Aplikasi ${_dataBank.bankName} MOBILE\n2. Buka BELI > TOP UP > ZIPAY\n3. Masukan ${_dataBank.vacctNo}\n4. Masukan nominal top up\n5. Ikuti instrusksi untuk melanjutkan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListVirtualBankArgs {
  Data data;
  ListVirtualBankArgs({this.data});
}