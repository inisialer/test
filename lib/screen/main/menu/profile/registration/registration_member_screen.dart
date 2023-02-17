import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/memberregistration/registration_member_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/businessowner/second_registration_business_owner_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/businessowner/third_registration_business_owner_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/employee/second_registration_employee_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/employee/third_registration_employee_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/init_registration_member_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/load_registration_member_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/registration_account_member_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/result_registration_member_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/submit_registration_member_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationMemberScreen extends StatefulWidget {
  const RegistrationMemberScreen({Key key}) : super(key: key);

  @override
  _RegistrationMemberScreenState createState() =>
      _RegistrationMemberScreenState();
}

class _RegistrationMemberScreenState extends State<RegistrationMemberScreen> {
  final _screen = ScreenUtil();
  PageController _controller = PageController(initialPage: 0);
  MemberRegistrationBloc _memberRegistrationBloc;
  DataMemberRegistration _dataMember;
  SharedPreferences _prefs = App().sharedPreferences;

  @override
  void initState() {
    super.initState();
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _memberRegistrationBloc.add(RegistrationMemberEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberRegistrationBloc, MemberRegistrationState>(
      listener: (context, state) async {
        if (state is RegistrationMemberSuccessState) {
          var token = await _prefs.getString(SharePrefs.ACCESS_TOKEN);
          print('Bearer $token');

          EasyLoading.dismiss();
          _dataMember = state.data?.data?.member ?? null;
          if (_dataMember == null || _dataMember?.isStep1Submitted == false) {
            _controller.jumpToPage(1);
          } else if (_dataMember.registrationStatus == 'submitted' ||
              _dataMember.registrationStatus == 'rejected' ||
              _dataMember.registrationStatus == 'approved')
            MyNavigator.goToResultRegistrationMember(
                context,
                ResultRegistrationMemberArguments(
                    _dataMember.registrationStatus, _dataMember.rejectReason));
          else if (_dataMember.isAccountSubmitted)
            _controller.jumpToPage(5);
          else if (_dataMember.isStep3Submitted)
            _controller.jumpToPage(4);
          else if (_dataMember.jobType == 'employee') {
            if (_dataMember.isStep2Submitted)
              _controller.jumpToPage(3);
            else if (_dataMember.isStep1Submitted) _controller.jumpToPage(2);
          } else if (_dataMember.jobType == 'business-owner') {
            if (_dataMember.isStep2Submitted)
              _controller.jumpToPage(7);
            else if (_dataMember.isStep1Submitted) _controller.jumpToPage(6);
          } else {}
        } else if (state is RegistrationMemberFailedState) {
          EasyLoading.dismiss();
        } else if (state is InitRegistrationMemberSuccessState) {
          EasyLoading.dismiss();
          if (state.jobType == 'employee') {
            _controller.jumpToPage(2);
            _dataMember.jobType = 'employee';
            _dataMember.isStep1Submitted = true;
          } else if (state.jobType == 'business-owner') {
            _controller.jumpToPage(6);
            _dataMember.jobType = 'business-owner';
            _dataMember.isStep1Submitted = true;
          }
        } else if (state is InitRegistrationMemberFailedState) {
          EasyLoading.dismiss();
        } else if (state is SecondRegistrationEmployeeSuccessState) {
          EasyLoading.dismiss();
          _controller.jumpToPage(3);
          _dataMember.isStep2Submitted = true;
        } else if (state is SecondRegistrationEmployeeFailedState) {
          EasyLoading.dismiss();
        } else if (state is SecondRegistrationBusinessOwnerSuccessState) {
          EasyLoading.dismiss();
          _controller.jumpToPage(7);
          _dataMember.isStep2Submitted = true;
        } else if (state is SecondRegistrationBusinessOwnerFailedState) {
          EasyLoading.dismiss();
        } else if (state is ThirdRegistrationEmployeeSuccessState) {
          EasyLoading.dismiss();
          _controller.jumpToPage(4);
          _dataMember.isStep3Submitted = true;
        } else if (state is ThirdRegistrationEmployeeFailedState) {
          EasyLoading.dismiss();
        } else if (state is ThirdRegistrationBusinessOwnerSuccessState) {
          EasyLoading.dismiss();
          _controller.jumpToPage(4);
          _dataMember.isStep3Submitted = true;
        } else if (state is ThirdRegistrationBusinessOwnerFailedState) {
          EasyLoading.dismiss();
        } else if (state is AccountRegistrationMemberSuccessState) {
          EasyLoading.dismiss();
          _controller.jumpToPage(5);
          _dataMember.isAccountSubmitted = true;
        } else if (state is AccountRegistrationMemberFailedState) {
          EasyLoading.dismiss();
        } else if (state is SubmitRegistrationMemberSuccessState) {
          EasyLoading.dismiss();
          MyNavigator.goToResultRegistrationMember(
              context, ResultRegistrationMemberArguments('', ''));
        } else if (state is SubmitRegistrationMemberFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<MemberRegistrationBloc, MemberRegistrationState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppUtil().parseHexColor(CustomColors.PALE_GREEN),
                  AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                ],
              ),
            ),
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      'Pendaftaran Anggota',
                      style: TextStyle(
                          color: AppUtil().parseHexColor(CustomColors.AMAZON),
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    bottom: PreferredSize(
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints.expand(height: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: (_dataMember?.isStep1Submitted ?? true)
                                      ? AppUtil().parseHexColor(
                                          CustomColors.JUNGLE_GREEN)
                                      : AppUtil()
                                          .parseHexColor(CustomColors.SILVER),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 24,
                              height: 8,
                            ),
                            SizedBox(width: 16),
                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: (_dataMember?.isStep1Submitted ??
                            //               false)
                            //           ? AppUtil().parseHexColor(
                            //               CustomColors.JUNGLE_GREEN)
                            //           : AppUtil()
                            //               .parseHexColor(CustomColors.SILVER),
                            //       borderRadius: BorderRadius.circular(8)),
                            //   width: 24,
                            //   height: 8,
                            // ),
                            // SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                  color: (_dataMember?.isStep2Submitted ??
                                          false)
                                      ? AppUtil().parseHexColor(
                                          CustomColors.JUNGLE_GREEN)
                                      : AppUtil()
                                          .parseHexColor(CustomColors.SILVER),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 24,
                              height: 8,
                            ),
                            SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                  color: (_dataMember?.isStep3Submitted ??
                                          false)
                                      ? AppUtil().parseHexColor(
                                          CustomColors.JUNGLE_GREEN)
                                      : AppUtil()
                                          .parseHexColor(CustomColors.SILVER),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 24,
                              height: 8,
                            ),
                            SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                  color: (_dataMember?.isAccountSubmitted ??
                                          false)
                                      ? AppUtil().parseHexColor(
                                          CustomColors.JUNGLE_GREEN)
                                      : AppUtil()
                                          .parseHexColor(CustomColors.SILVER),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 24,
                              height: 8,
                            )
                          ],
                        ),
                      ),
                      preferredSize: Size(200, 20),
                    ),
                    leading: GestureDetector(
                        onTap: () {
                          MyNavigator.goClose(context);
                        },
                        child: Image.asset('assets/icon/ic_back.png'))),
                backgroundColor: Colors.transparent,
                body: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: _screen.widthDefault(context) / 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    child: PageView(
                      controller: _controller,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        LoadRegistrationMemberScreen(),
                        InitRegistrationMemberScreen(),
                        SecondRegistrationEmployeeScreen(),
                        ThirdRegistrationEmployeeScreen(),
                        RegistrationAccountMemberScreen(),
                        SubmitRegistrationMemberScreen(),
                        SecondRegistrationBusinessOwnerScreen(),
                        ThirdRegistrationBusinessOwnerScreen()
                      ],
                    ))),
          );
        },
      ),
    );
  }
}
