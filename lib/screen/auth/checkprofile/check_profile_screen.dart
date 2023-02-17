import 'dart:convert';

import 'package:alhikmah_app/bloc/auth/bloc.dart';
import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/screen/auth/checkotp/check_otp_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/image_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/util/validate_helper.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_textfield_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';

class CheckProfileScreen extends StatefulWidget {
  const CheckProfileScreen({Key key}) : super(key: key);

  @override
  _CheckProfileScreenState createState() => _CheckProfileScreenState();
}

class _CheckProfileScreenState extends State<CheckProfileScreen> {
  UtilBloc _utilBloc;
  AuthBloc _authBloc;
  final _screen = ScreenUtil();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();
  SharedPreferences _prefs = App().sharedPreferences;
  String _photoProfile = '';
  String _objectPhoto = '';
  String _urlPhoto = '';
  final _regexEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void initState() {
    _utilBloc = BlocProvider.of<UtilBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CheckProfileArguments args = ModalRoute.of(context).settings.arguments;
    return MultiBlocListener(
      listeners: [
        BlocListener<UtilBloc, UtilState>(
          listener: (context, state) {
            if (state is UploadPublicSuccessState) {
              EasyLoading.dismiss();
              if (_objectPhoto != null) {
                _objectPhoto = state.data.data.objectName;
                _urlPhoto = state.data.data.url;
              }
            } else if (state is UploadPublicFailedState) {
              EasyLoading.dismiss();
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              EasyLoading.dismiss();
              _prefs.setString(SharePrefs.NAME,
                  _firstName.text.toString() + ' ' + _lastName.text.toString());
              _prefs.setString(SharePrefs.PHOTO_PROFILE, _urlPhoto);
              var data = {
                'phone': args.data['phone'],
                'isRegister': true,
              };
              MyNavigator.goToCheckOtp(context, CheckOtpArguments(data));
            } else if (state is RegisterFailedState) {
              EasyLoading.dismiss();
            }
          },
        ),
      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(height: _screen.heightDefault(context) / 30),
                    Image.asset(
                      Images.LOGO_ALHIKMAH,
                      height: _screen.heightDefault(context) / 16,
                    ),
                    SizedBox(height: _screen.heightDefault(context) / 40),
                    Center(
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: !ValidateHelper.isEmpty(_photoProfile)
                            ? MemoryImage(base64Decode(_photoProfile))
                            : AssetImage(Images.PROFILE_NONE),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _screen.widthDefault(context) / 3),
                      child: CustomButtonOutline(
                        title: 'Upload Foto',
                        onTap: () {
                          _showOptionsUpload(context, 'profile-photo');
                        },
                      ),
                    ),
                    SizedBox(height: _screen.heightDefault(context) / 40),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _screen.heightDefault(context) / 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Nama Depan'),
                          ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _firstName,
                              builder: (context, value, child) {
                                return CustomTextFieldCheck(
                                  controller: _firstName,
                                  isSuffix: _firstName.text.length >= 3,
                                );
                              }),
                          SizedBox(height: _screen.heightDefault(context) / 40),
                          CustomText(text: 'Nama Belakang'),
                          ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _lastName,
                              builder: (context, value, child) {
                                return CustomTextFieldCheck(
                                  controller: _lastName,
                                  isSuffix: _lastName.text.length >= 3,
                                );
                              }),
                          SizedBox(height: _screen.heightDefault(context) / 40),
                          CustomText(text: 'Email'),
                          ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _email,
                              builder: (context, value, child) {
                                return CustomTextFieldCheck(
                                  controller: _email,
                                  isSuffix: _regexEmail.hasMatch(_email.text),
                                );
                              })
                        ],
                      ),
                    ),
                    SizedBox(height: _screen.heightDefault(context) / 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _firstName,
                            builder: (context, value, child) {
                              return ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: _lastName,
                                  builder: (context, value, child) {
                                    return ValueListenableBuilder<
                                            TextEditingValue>(
                                        valueListenable: _email,
                                        builder: (context, value, child) {
                                          return CustomButtonRaised(
                                            title: 'Lanjut',
                                            isCompleted:
                                                (_firstName.text.length >= 3 &&
                                                    _lastName.text.length >=
                                                        3 &&
                                                    _regexEmail
                                                        .hasMatch(_email.text)),
                                            onTap: () {
                                              setState(() {
                                                (_firstName.text.length >= 3 &&
                                                        _lastName.text.length >=
                                                            3 &&
                                                        _regexEmail.hasMatch(
                                                            _email.text))
                                                    ? _setProfile(
                                                        _objectPhoto,
                                                        _firstName.text,
                                                        _lastName.text,
                                                        _email.text,
                                                        args.data['phone'],
                                                        args.data['pin'],
                                                      )
                                                    : print('Not yet');
                                              });
                                            },
                                          );
                                        });
                                  });
                            }),
                        SizedBox(height: _screen.heightDefault(context) / 50),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: _screen.heightDefault(context) / 30,
                              left: _screen.widthDefault(context) / 20,
                              right: _screen.widthDefault(context) / 6),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'Dengan menekan “Lanjut” saya setuju dengan ',
                                style: TextStyle(
                                    color: AppUtil()
                                        .parseHexColor(CustomColors.CHARCOAL))),
                            TextSpan(
                                text: 'Syarat dan Ketentuan',
                                style: TextStyle(
                                    color: AppUtil()
                                        .parseHexColor(CustomColors.FERN))),
                          ])),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _setProfile(String photoProfile, String firstName, String lastName,
      String email, String phone, String pin) {
    AppUtil().hideKeyboard(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );

    _authBloc.add(RegisterEvent(
        email: email,
        firstName: firstName,
        lastName: lastName,
        profilePhoto: photoProfile,
        phone: phone,
        pin: pin));
  }

  void _showOptionsUpload(BuildContext context, String category) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: _screen.heightDefault(context) / 5.5,
              child: Column(children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Take a picture from camera'),
                  onTap: () {
                    ImageUtil().postImageCamera((file) {
                      Navigator.pop(context);
                      setState(() {
                        _photoProfile = base64Encode(file.readAsBytesSync());
                      });
                      EasyLoading.show(
                        status: 'Loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      _utilBloc.add(
                          UploadPublicEvent(file: file, category: category));
                      return;
                    });
                  },
                ),
                ListTile(
                    onTap: () {
                      ImageUtil().postImageGallery((file) {
                        Navigator.pop(context);

                        setState(() {
                          _photoProfile = base64Encode(file.readAsBytesSync());
                        });
                        EasyLoading.show(
                          status: 'Loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        _utilBloc.add(
                            UploadPublicEvent(file: file, category: category));
                        return;
                      });
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text('Choose from photo library'))
              ]));
        });
  }
}

class CheckProfileArguments {
  final dynamic data;

  CheckProfileArguments(this.data);
}
