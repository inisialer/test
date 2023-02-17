import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/model/user/virtual_account_model.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'package:alhikmah_app/screen/main/ppob/topup/widget/item_bank.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({Key key}) : super(key: key);

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  UserBloc _userBloc;
  VirtualAccountModel _itemVirtualAccount;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _userBloc.add(VaZipayEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is GetVaZipaySuccessState) {
          EasyLoading.dismiss();
          _itemVirtualAccount = state.data;
        } else if (state is GetVaZipayFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Top Up',
            body: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
              child: ListView(
                children: [
                  CustomText(text: 'Bank Transfer'),
                  ListView.builder(
                      itemCount: _itemVirtualAccount?.data?.length ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _ItemBank(
                            item: _itemVirtualAccount?.data[index]);
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
