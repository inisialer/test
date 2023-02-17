import 'package:alhikmah_app/bloc/ppob/bpjs/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/screen/main/ppob/bpjs/bpjs_detail_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_textfield_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class BpjsScreen extends StatefulWidget {
  const BpjsScreen({Key key}) : super(key: key);

  @override
  _BpjsScreenState createState() => _BpjsScreenState();
}

class _BpjsScreenState extends State<BpjsScreen> {
  TextEditingController _noVa = TextEditingController();
  TextEditingController _untilPayment = TextEditingController();
  String _payUntil = '';
  final _screen = ScreenUtil();

  BpjsBloc _bpjsBloc;

  @override
  void initState() {
    super.initState();
    _bpjsBloc = BlocProvider.of<BpjsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BpjsBloc, BpjsState>(
      listener: (context, state) {
        if (state is GetInquiryBpjsSuccessState) {
          EasyLoading.dismiss();
          var data = PaymentModel(
              no: _noVa.text,
              bpjsNo: _noVa.text,
              bpjsPeriod: state.data.data.periode,
              bpjsName: state.data.data.customerName,
              bill: state.data.data.nominal,
              admin: state.data.data.adminFee,
              total: state.data.data.totalNominal,
              noTransaction: state.data.data.transactionId);
          MyNavigator.goToHomeBPJSDetail(context, BpjsDetailArguments(data));
        } else if (state is GetInquiryBpjsFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<UtilBloc, UtilState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'BPJS',
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _screen.widthDefault(context) / 16),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      SizedBox(height: _screen.heightDefault(context) / 20),
                      CustomText(text: 'No. VA Keluarga'),
                      ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _noVa,
                          builder: (context, value, child) {
                            return CustomTextFieldNumber(controller: _noVa);
                          }),
                      SizedBox(height: _screen.heightDefault(context) / 40),
                      CustomText(text: 'Bayar Sampai'),
                      ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _untilPayment,
                          builder: (context, value, child) {
                            return GestureDetector(
                              onTap: () {
                                AppUtil().hideKeyboard(context);
                                showMonthPicker(
                                  context: context,
                                  firstDate:
                                      DateTime(DateTime.now().year - 1, 5),
                                  lastDate:
                                      DateTime(DateTime.now().year + 1, 9),
                                  initialDate: DateTime.now(),
                                  locale: Locale("id"),
                                ).then((date) {
                                  if (date != null) {
                                    setState(() {
                                      var dateShow =
                                          DateFormat('MMMM yyyy').format(date);
                                      var dateData =
                                          DateFormat('yyyy-MM').format(date);
                                      _payUntil = dateData;
                                      _untilPayment.text = dateShow;
                                    });
                                  }
                                });
                              },
                              child: Container(
                                color: Colors.white,
                                child: IgnorePointer(
                                  child: CustomTextFieldNumber(
                                    controller: _untilPayment,
                                    isSuffix: false,
                                    isReadOnly: true,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: _screen.heightDefault(context) / 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _noVa,
                              builder: (context, value, child) {
                                return CustomButtonRaised(
                                  onTap: () {
                                    EasyLoading.show(
                                      status: 'Loading...',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    _bpjsBloc.add(InquiryBpjsEvent(
                                        familyVaNumber: _noVa.text,
                                        payUntil: _payUntil));
                                  },
                                  isCompleted: _noVa.text.isNotEmpty &&
                                      _payUntil.isNotEmpty,
                                  title: 'Lanjut',
                                );
                              }),
                          SizedBox(width: _screen.widthDefault(context) / 16),
                          ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _noVa,
                              builder: (context, value, child) {
                                return CustomButtonOutline(
                                  onTap: () {
                                    MyNavigator.goClose(context);
                                  },
                                  title: 'Batal',
                                );
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
