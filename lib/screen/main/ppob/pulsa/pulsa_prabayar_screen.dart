import 'package:alhikmah_app/bloc/ppob/pulsa/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/ppob/pulsa/recent_pulsa_prabayar_phone_model.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/data/item_phone.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_detail_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_textfield_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'package:alhikmah_app/screen/main/ppob/pulsa/widget/item_recent_pulsa_prabayar_phone.dart';

class PulsaPrabayarScreen extends StatefulWidget {
  const PulsaPrabayarScreen({Key key}) : super(key: key);

  @override
  _PulsaPrabayarScreenState createState() => _PulsaPrabayarScreenState();
}

class _PulsaPrabayarScreenState extends State<PulsaPrabayarScreen> {
  TextEditingController _noPhone = TextEditingController();
  final _screen = ScreenUtil();
  PulsaBloc _pulsaBloc;
  RecentPulsaPrabayarPhoneModel _itemRecentPulsaPhone;

  @override
  void initState() {
    super.initState();
    _pulsaBloc = BlocProvider.of<PulsaBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _pulsaBloc.add(RecentPulsaPrabayarPhoneEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PulsaBloc, PulsaState>(
      listener: (context, state) {
        if (state is GetPhoneProviderSuccessState) {
          EasyLoading.dismiss();
          var data = ItemPhoneModel(
              phone: _noPhone.text,
              logo: state.data.data.provider.picture,
              provider: state.data.data.provider.provider);
          AppUtil().hideKeyboard(context);
          MyNavigator.goToHomePulsaDetail(
              context, PulsaPrabayarDetailArguments(data));
        } else if (state is GetPhoneProviderFailedState) {
          EasyLoading.dismiss();
        } else if (state is GetRecentPulsaPrabayarPhoneSuccessState) {
          EasyLoading.dismiss();
          _itemRecentPulsaPhone = state.data;
        } else if (state is GetRecentPulsaPrabayarPhoneFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PulsaBloc, PulsaState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Pulsa',
            body: Padding(
              padding:
                  EdgeInsets.only(top: _screen.heightDefault(context) / 20),
              child: Container(
                height: double.infinity,
                color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: _screen.widthDefault(context) / 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(text: 'No. Telepon'),
                          ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _noPhone,
                              builder: (context, value, child) {
                                return CustomTextFieldNumber(
                                    controller: _noPhone);
                              }),
                          SizedBox(height: _screen.heightDefault(context) / 40),
                          ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _noPhone,
                              builder: (context, value, child) {
                                return CustomButtonRaised(
                                  onTap: () {
                                    var phone = _noPhone.text;

                                    if ((_noPhone.text[0] +
                                            _noPhone.text[1] +
                                            _noPhone.text[2]) ==
                                        '+62') {
                                      phone =
                                          _noPhone.text.replaceRange(0, 3, '0');
                                    } else if ((_noPhone.text[0] +
                                            _noPhone.text[1]) ==
                                        '62') {
                                      final repReg = RegExp(r'\d{2}');
                                      phone = _noPhone.text
                                          .replaceFirst(repReg, '0');
                                    } else if (_noPhone.text[0] == '8') {
                                      final repReg = RegExp(r'\d{1}');
                                      phone = _noPhone.text
                                          .replaceFirst(repReg, '08');
                                    }

                                    EasyLoading.show(
                                      status: 'Loading...',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    _pulsaBloc.add(PhoneProviderEvent(
                                        code: phone.substring(0, 4)));
                                  },
                                  isCompleted: _noPhone.text.length >= 9,
                                  title: 'Konfirmasi',
                                );
                              }),
                          SizedBox(
                            height: _screen.heightDefault(context) / 40,
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
                      padding: EdgeInsets.only(
                          left: _screen.widthDefault(context) / 16,
                          right: _screen.widthDefault(context) / 16,
                          top: _screen.heightDefault(context) / 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomor terakhir',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppUtil()
                                    .parseHexColor(CustomColors.NOBEL)),
                          ),
                          SizedBox(height: _screen.heightDefault(context) / 40),
                          ListView.builder(
                              itemCount:
                                  _itemRecentPulsaPhone?.data?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () => _noPhone.text =
                                        _itemRecentPulsaPhone
                                            ?.data[index].phoneNumber,
                                    child: _ItemRecentPulsaPrabayarPhone(
                                      item: _itemRecentPulsaPhone?.data[index],
                                    ));
                              }),
                          SizedBox(height: _screen.heightDefault(context) / 40),
                          Container(
                            color: AppUtil()
                                .parseHexColor(CustomColors.WHITE_SMOKE),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
