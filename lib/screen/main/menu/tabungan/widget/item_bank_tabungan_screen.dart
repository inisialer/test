import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment_final.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_bank_screen.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../model/payment/item_va_bank.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';

import '../../../ppob/payment/payment_zipay_screen.dart';

class ItemBankTabungan extends StatelessWidget {
  final DataBank item;
  final String transaksiId;
  final String typeTransaksi;
  final bool isTagihan;
  final bool isSaldoAda;

  ItemBankTabungan(
      {Key key,
      this.item,
      this.transaksiId,
      this.typeTransaksi,
      this.isSaldoAda,
      this.isTagihan: false})
      : super(key: key);

  final _screen = ScreenUtil();
  PaymentBloc paymentBloc = PaymentBloc();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: transaksiId == '-'
          ? null
          : () {
              if (isSaldoAda == true) {
                if (isTagihan) {
                  if (item.bankName == "Zipay") {
                    paymentBloc.add(TagihanPaymentMethodEvent(
                        paymentMethod: "zipay",
                        transactionId: transaksiId,
                        vaBankCode: ''));
                  } else {
                    paymentBloc.add(TagihanPaymentMethodEvent(
                        paymentMethod: "va",
                        transactionId: transaksiId,
                        vaBankCode: item.bankCode));
                  }
                } else {
                  if (item.bankName == "Zipay") {
                    paymentBloc.add(SavingPaymentMethodEvent(
                        paymentMethod: "zipay",
                        transactionId: transaksiId,
                        vaBankCode: ''));
                  } else {
                    paymentBloc.add(SavingPaymentMethodEvent(
                        paymentMethod: "va",
                        transactionId: transaksiId,
                        vaBankCode: item.bankCode));
                  }
                }
              } else {
                if (item.bankName == "Zipay") {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height:
                                        _screen.heightDefault(context) / 100),
                                Center(
                                  child: Text(
                                    "Silahkan isi saldo Zipay anda terlebih dahulu",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButtonRaised(
                                        title: 'Cancel',
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        isCompleted: true,
                                      )
                                    ]),
                                SizedBox(
                                    height:
                                        _screen.heightDefault(context) / 120),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  paymentBloc.add(SavingPaymentMethodEvent(
                      paymentMethod: "va",
                      transactionId: transaksiId,
                      vaBankCode: item.bankCode));
                }
              }
            },
      child: BlocListener<PaymentBloc, PaymentState>(
        bloc: paymentBloc,
        listener: (context, state) {
          if (state is PaymentInitial) {
            EasyLoading.show(
              status: 'Loading...',
              maskType: EasyLoadingMaskType.black,
            );
          }
          if (state is BillerPaymentMethodSuccessState) {
            EasyLoading.dismiss();

            if (item.bankName == "Zipay") {
              var data = PaymentFinalModel(
                  noTransaction: state.data.data.transactionId,
                  type: typeTransaksi,
                  fromMenu: 'home',
                  va: '');
              MyNavigator.goToHomePaymentZipay(
                  context, PaymentZipayArguments(data));
            } else {
              var data = PaymentFinalModel(
                  noTransaction: state.data.data.transactionId,
                  type: typeTransaksi,
                  bank: item,
                  fromMenu: 'home',
                  va: '');
              MyNavigator.goToHomePaymentBank(
                  context, PaymentBankArguments(data));
            }
          }else if (state is BillerPaymentMethodFailedState) {
            EasyLoading.dismiss();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            color: transaksiId == '-' ? Colors.grey.shade200 : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.only(top: _screen.heightDefault(context) / 100),
          padding: EdgeInsets.symmetric(
              horizontal: _screen.widthDefault(context) / 24,
              vertical: _screen.heightDefault(context) / 100),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  item.bankName == 'Zipay'
                      ? Image.asset(
                          item.bankLogo,
                          width: _screen.widthDefault(context) / 5,
                          height: _screen.heightDefault(context) / 18,
                        )
                      : Image.network(
                          item.bankLogo,
                          width: _screen.widthDefault(context) / 5,
                          height: _screen.heightDefault(context) / 18,
                        ),
                  SizedBox(width: _screen.widthDefault(context) / 40),
                  Text(
                    item.bankName,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.CHARCOAL)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
