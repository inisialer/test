import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'package:alhikmah_app/screen/main/ppob/payment/widget/item_bank.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key key}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _screen = ScreenUtil();
  PaymentBloc _paymentBloc;
  ItemVaBankModel _itemListBankModel;

  @override
  void initState() {
    super.initState();
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _paymentBloc.add(VaBankEvent());
  }

  var _itemZipay =
      DataBank(bankLogo: 'assets/image/img_bank_zipay.png', bankName: 'Zipay');

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is GetVaBankSuccessState) {
          EasyLoading.dismiss();
          _itemListBankModel = state.data;
        } else if (state is GetVaBankFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Metode Pembayaran',
            body: Padding(
              padding: EdgeInsets.only(
                  top: _screen.heightDefault(context) / 100,
                  left: _screen.widthDefault(context) / 16,
                  right: _screen.widthDefault(context) / 16),
              child: ListView(
                children: [
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  _ItemBank(item: _itemZipay),
                  SizedBox(height: _screen.heightDefault(context) / 24),
                  CustomText(text: 'Bank Transfer'),
                  ListView.builder(
                      itemCount: _itemListBankModel?.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _ItemBank(item: _itemListBankModel?.data[index]);
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
