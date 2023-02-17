import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_container_rounded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../bloc/memberregistration/bloc.dart';

part 'package:alhikmah_app/screen/main/menu/profile/widget/item_menu.dart';

part 'package:alhikmah_app/screen/main/menu/profile/widget/item_title_menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _screen = ScreenUtil();
  SharedPreferences _prefs = App().sharedPreferences;
  MemberRegistrationBloc _memberRegistrationBloc;

  @override
  void initState() {
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
    _memberRegistrationBloc.add(RegistrationMemberEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                    image: AssetImage(Images.HEADER), fit: BoxFit.cover),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: _screen.widthDefault(context) / 24,
                    right: _screen.widthDefault(context) / 50,
                    top: _screen.heightDefault(context) / 32),
                child: Column(
                  children: [
                    Center(child: Image.asset(Images.LOGO_ALHIKMAH)),
                    SizedBox(height: _screen.heightDefault(context) / 60),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: _prefs
                                  .getString(SharePrefs.PHOTO_PROFILE)
                                  .isNotEmpty
                              ? NetworkImage(
                                  _prefs.getString(SharePrefs.PHOTO_PROFILE))
                              : AssetImage(Images.PROFILE_NONE),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: _screen.widthDefault(context) / 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _prefs.getString(SharePrefs.NAME),
                              style: TextStyle(
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.AMAZON),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.AMAZON),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.AMAZON),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: _screen.heightDefault(context) / 50),
                  ],
                ),
              ),
            ),
          ],
        ),
        BlocBuilder(
          builder: (context, state) {
            if (state is RegistrationMemberSuccessState) {
              if (state.data.data.member!= null) {
                if(state.data.data.member.registrationStatus == "done"){
                  return Container(
                    width: _screen.widthDefault(context),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[500].withOpacity(0.3),
                              offset: Offset(0, 0),
                              spreadRadius: 3,
                              blurRadius: 3)
                        ]),
                    child: Wrap(
                      spacing: 10,
                      children: [
                        Text("Tipe Akun", style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),),
                        Text(
                          "Anggota Koperasi",
                          style: TextStyle(
                              color: AppUtil()
                                  .parseHexColor(CustomColors.PALE_GREEN),
                              fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
              }
              return Padding(
                padding: EdgeInsets.only(
                    left: _screen.widthDefault(context) / 24,
                    right: _screen.widthDefault(context) / 24,
                    top: _screen.heightDefault(context) / 40),
                child: GestureDetector(
                  onTap: () =>
                      MyNavigator.goToProfileRegistrationMember(context),
                  child: Container(
                    padding:
                    EdgeInsets.all(_screen.widthDefault(context) / 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(55),
                      color: AppUtil()
                          .parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Daftar Menjadi Anggota Koperasi',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
          bloc: _memberRegistrationBloc,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: _screen.widthDefault(context) / 24,
              right: _screen.widthDefault(context) / 24,
              top: _screen.heightDefault(context) / 40),
          child: CustomContainerRounded(
            paddingVertical: _screen.heightDefault(context) / 120,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ItemTitleMenu(title: 'Pengaturan Aplikasi'),
                SizedBox(height: _screen.widthDefault(context) / 40),
                /*GestureDetector(
                    onTap: () => AppUtil.showToast('Sedang tahap pengembangan'),
                    child: _ItemMenu(
                      title: 'Pengaturan Profil',
                    )),
                GestureDetector(
                    onTap: () => AppUtil.showToast('Sedang tahap pengembangan'),
                    child: _ItemMenu(
                      title: 'Ubah PIN',
                    )),*/
                GestureDetector(
                    onTap: () async {
                      PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();

                      String appName = packageInfo.appName;
                      String version = packageInfo.version;
                      String buildNumber = packageInfo.buildNumber;
                      AppUtil.showToast('$appName $version($buildNumber)');
                    },
                    child: _ItemMenu(
                      title: 'Versi Aplikasi',
                    )),
                GestureDetector(
                    onTap: () {
                      MyNavigator.goToCheckPhone(context);
                      AppUtil.showToast('Berhasil Log out');
                      _prefs.setString(SharePrefs.REFRESH_TOKEN, '');
                      _prefs.setString(SharePrefs.ACCESS_TOKEN, '');
                      _prefs.setInt(SharePrefs.EXPIRES_TOKEN, 0);
                      _prefs.setString(SharePrefs.NAME, '');
                      _prefs.setString(SharePrefs.PHOTO_PROFILE, '');
                      _prefs.setBool(SharePrefs.IS_LOGIN, false);
                    },
                    child: _ItemMenu(
                      title: 'Keluar',
                      colorText:
                          AppUtil().parseHexColor(CustomColors.BURNT_SIENNA),
                    )),
                SizedBox(height: _screen.heightDefault(context) / 100)
              ],
            ),
          ),
        ),
        /*Padding(
          padding: EdgeInsets.only(
              left: _screen.widthDefault(context) / 24,
              right: _screen.widthDefault(context) / 24,
              top: _screen.heightDefault(context) / 40),
          child: CustomContainerRounded(
            paddingVertical: _screen.heightDefault(context) / 120,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ItemTitleMenu(title: 'Informasi Akun'),
                SizedBox(height: _screen.heightDefault(context) / 100),
                GestureDetector(
                    onTap: () => AppUtil.showToast('Sedang tahap pengembangan'),
                    child: _ItemMenu(
                      title: 'Daftar Rekening',
                    )),
                GestureDetector(
                    onTap: () => AppUtil.showToast('Sedang tahap pengembangan'),
                    child: _ItemMenu(
                      title: 'Dokumen',
                    )),
                SizedBox(height: _screen.heightDefault(context) / 100)
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                left: _screen.widthDefault(context) / 24,
                right: _screen.widthDefault(context) / 24,
                top: _screen.heightDefault(context) / 40),
            child: CustomContainerRounded(
              paddingVertical: _screen.heightDefault(context) / 120,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ItemTitleMenu(title: 'Informasi Umum'),
                  SizedBox(height: _screen.heightDefault(context) / 100),
                  GestureDetector(
                      onTap: () =>
                          AppUtil.showToast('Sedang tahap pengembangan'),
                      child: _ItemMenu(
                        title: 'Tutorial',
                      )),
                  GestureDetector(
                      onTap: () =>
                          AppUtil.showToast('Sedang tahap pengembangan'),
                      child: _ItemMenu(
                        title: 'Pusat Bantuan',
                      )),
                  GestureDetector(
                      onTap: () =>
                          AppUtil.showToast('Sedang tahap pengembangan'),
                      child: _ItemMenu(
                        title: 'FAQ',
                      )),
                  GestureDetector(
                      onTap: () =>
                          AppUtil.showToast('Sedang tahap pengembangan'),
                      child: _ItemMenu(
                        title: 'Kebijakan Privasi',
                      )),
                  SizedBox(height: _screen.heightDefault(context) / 100)
                ],
              ),
            )),*/
        SizedBox(height: _screen.heightDefault(context) / 6.5)
      ],
    );
  }
}
