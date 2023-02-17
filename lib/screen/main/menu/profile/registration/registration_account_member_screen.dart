import 'dart:convert';

import 'package:alhikmah_app/bloc/master/bloc.dart';
import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_dropdown_form.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_text_field_form.dart';
import 'package:alhikmah_app/widget/custom_textfield_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegistrationAccountMemberScreen extends StatefulWidget {
  const RegistrationAccountMemberScreen({Key key}) : super(key: key);

  @override
  _RegistrationAccountMemberScreenState createState() =>
      _RegistrationAccountMemberScreenState();
}

class _RegistrationAccountMemberScreenState extends State<RegistrationAccountMemberScreen> {
  final _screen = ScreenUtil();
  TextEditingController _accountHolderName = TextEditingController();
  TextEditingController _accountNumber = TextEditingController();
  MemberRegistrationBloc _memberRegistrationBloc;
  MasterBloc _masterBloc;

  String _disburseBank;
  List<dynamic> _disburseBanks = [];

  @override
  void initState() {
    super.initState();
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
    _masterBloc = BlocProvider.of<MasterBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _masterBloc.add(DisburseBankEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MasterBloc, MasterState>(
          listener: (context, state) {
            if (state is GetDisburseBankSuccessState) {
              var disburseBanks =
                  JsonDecoder().convert(jsonEncode(state.data.data));
              _disburseBanks = disburseBanks;
              EasyLoading.dismiss();
            } else if (state is GetResidenceStatusFailedState) {
              EasyLoading.dismiss();
            }
          },
        ),
        BlocListener<UtilBloc, UtilState>(
          listener: (context, state) {
            if (state is SetDropdownState) {
              if (state.category == 'akunbank') {
                setState(() {
                  _disburseBank = state.item;
                });
              }
            }
          },
        ),
      ],
      child: BlocBuilder<MasterBloc, MasterState>(
        builder: (context, state) {
          return ListView(
            children: [
              SizedBox(height: _screen.heightDefault(context) / 40),
              Center(
                child: CustomText(text: 'Data Rekening', fontSize: 20),
              ),
              SizedBox(height: _screen.heightDefault(context) / 40),
              CustomText(
                text: 'Bank',
                color: AppUtil().parseHexColor(CustomColors.NOBEL),
              ),
              CustomDropdownForm(
                itemValue: _disburseBank,
                itemData: _disburseBanks,
                idKey: 'bankCode',
                nameKey: 'bankName',
                category: 'akunbank',
                hint: 'Pilih bank',
                color: AppUtil().parseHexColor(CustomColors.MORTAR),
              ),
              SizedBox(height: _screen.heightDefault(context) / 40),
              CustomText(
                text: 'Nomor rekening',
                color: AppUtil().parseHexColor(CustomColors.NOBEL),
              ),
              CustomTextFieldNumber(
                  controller: _accountNumber,
                  color: AppUtil().parseHexColor(CustomColors.MORTAR)),
              SizedBox(height: _screen.heightDefault(context) / 40),
              CustomText(
                text: 'Nama pada rekening',
                color: AppUtil().parseHexColor(CustomColors.NOBEL),
              ),
              CustomTextFieldForm(
                  controller: _accountHolderName,
                  keyboardType: TextInputType.name,
                  color: AppUtil().parseHexColor(CustomColors.MORTAR)),
              SizedBox(height: _screen.heightDefault(context) / 24),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CustomButtonRaised(
                    title: 'Lanjut',
                    onTap: () {
                      EasyLoading.show(
                        status: 'Loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      _memberRegistrationBloc.add(
                          AccountRegistrationMemberEvent(
                              accountHolderName: _accountHolderName.text,
                              accountNumber: _accountNumber.text,
                              accountBankCode: _disburseBank));
                    },
                    isCompleted: _disburseBank != null &&
                        _accountNumber.text.isNotEmpty &&
                        _accountHolderName.text.isNotEmpty)
              ])
            ],
          );
        },
      ),
    );
  }
}
