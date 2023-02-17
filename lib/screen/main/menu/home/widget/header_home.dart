part of 'package:alhikmah_app/screen/main/menu/home/home_screen.dart';

class _HeaderHome extends StatefulWidget {
  const _HeaderHome({Key key}) : super(key: key);

  @override
  _HeaderHomeState createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<_HeaderHome>
    with AfterInitMixin<_HeaderHome> {
  RegistrationStatusBloc registrationStatusBloc = RegistrationStatusBloc();
  MemberRegistrationBloc _memberRegistrationBloc;
  UserBloc _userBloc;
  final _screen = ScreenUtil();
  String _timeString;
  Timer _clockTimer;
  SharedPreferences _prefs = App().sharedPreferences;
  String _time = '';
  int _wallet = 0;

  String totalTabungan;

  @override
  void initState() {
    _getTimeDivision();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _memberRegistrationBloc = BlocProvider.of<MemberRegistrationBloc>(context);
    registrationStatusBloc.add(GetRegistrationStatus());
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _memberRegistrationBloc.add(RegistrationMemberEvent());
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _userBloc.add(BalanceEvent(state: 'home'));
    getTotalTabungan();
    super.initState();
  }

  getTotalTabungan() async {
    String _result = await TabunganListService().totalTabungan();

    setState(() {
      totalTabungan = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // registrationStatusBloc.add(GetRegistrationStatus());
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is GetBalanceSuccessState) {
          EasyLoading.dismiss();
          if (state.state == 'home') {
            _wallet = state.data.data.balance;
          }
        } else if (state is GetBalanceFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                      image: AssetImage(Images.HEADER), fit: BoxFit.cover),
                ),
                padding: EdgeInsets.only(
                    top: _screen.heightDefault(context) / 32,
                    left: _screen.widthDefault(context) / 20,
                    right: _screen.widthDefault(context) / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(Images.LOGO_ALHIKMAH)),
                    SizedBox(height: _screen.heightDefault(context) / 60),
                    Text(
                      'Assalamulaikum \n${_prefs.getString(SharePrefs.NAME)}',
                      style: TextStyle(
                          color: AppUtil().parseHexColor(CustomColors.AMAZON),
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                    Text('$_time',
                        style: TextStyle(
                            color: AppUtil().parseHexColor(CustomColors.AMAZON),
                            fontSize: 12,
                            fontWeight: FontWeight.w800)),
                    SizedBox(height: _screen.heightDefault(context) / 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocConsumer(
                          bloc: _memberRegistrationBloc,
                          listener: (context, state) {
                            if (state is RegistrationMemberSuccessState) {
                              EasyLoading.dismiss();
                            }
                          },
                          builder: (contexet, state) {
                            String memberNumber = "-";
                            if (state is RegistrationMemberSuccessState) {
                              if (state.data != null) {
                                if (state.data.data != null) {
                                  if (state.data.data.member != null) {
                                    if (state.data.data.member.memberNumber !=
                                        null) {
                                      memberNumber =
                                          state.data.data.member.memberNumber;
                                    }
                                  }
                                }
                              }
                            }
                            return memberNumber != "-"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Nomor Anggota Koperasi',
                                          style: TextStyle(
                                              color: AppUtil().parseHexColor(
                                                  CustomColors.AMAZON),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600)),
                                      Text(memberNumber,
                                          style: TextStyle(
                                              color: AppUtil().parseHexColor(
                                                  CustomColors.AMAZON),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  )
                                : Text("");
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(_timeString,
                                style: TextStyle(
                                    color: AppUtil()
                                        .parseHexColor(CustomColors.AMAZON),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            Text('',
                                style: TextStyle(
                                    color: AppUtil()
                                        .parseHexColor(CustomColors.AMAZON),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: _screen.heightDefault(context) / 20),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: _screen.widthDefault(context) / 20,
                    right: _screen.widthDefault(context) / 20,
                    top: _screen.heightDefault(context) / 3.8),
                child: BlocConsumer<RegistrationStatusBloc,
                    RegistrationStatusState>(
                  bloc: registrationStatusBloc,
                  listener: (context, state) {
                    if (state is RegistrationStatusLoaded) {
                      print(state.registrationStatusModel);
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is RegistrationStatusLoaded)
                      return Column(
                        children: [
                          NotifHome(
                            registrationStatusModel:
                                state.registrationStatusModel != null
                                    ? state.registrationStatusModel
                                    : null,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                _screen.widthDefault(context) / 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.INFO_BAR),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: false,
                                  child: Text('',
                                      style: TextStyle(
                                          color: AppUtil().parseHexColor(
                                              CustomColors.MORTAR),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(
                                    height:
                                        _screen.heightDefault(context) / 100),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/tabungan_screen');
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              _screen.widthDefault(context) /
                                                  65),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/icon/ic_main_investasi.png'),
                                              Text(
                                                'Tabungan',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12,
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors
                                                                .MORTAR)),
                                              ),
                                              SizedBox(
                                                  width: _screen.widthDefault(
                                                          context) /
                                                      60),
                                              Text(totalTabungan ?? '0',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 12,
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                              CustomColors
                                                                  .MORTAR)))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: (){
                                          MyNavigator.goToZipayHomePage(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              _screen.widthDefault(context) / 65),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/image/img_bank_zipay.png',
                                                width: 55,
                                              ),
                                              Text(
                                                'Zipay',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                        CustomColors.MORTAR)),
                                              ),
                                              SizedBox(
                                                  width: _screen
                                                      .widthDefault(context) /
                                                      60),
                                              Text(
                                                  AppUtil()
                                                      .formattedMoneyIDR(_wallet),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 10,
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                          CustomColors
                                                              .MORTAR)))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          if (state.registrationStatusModel.data
                                                  .registrationStatus ==
                                              "done") {
                                            Navigator.pushNamed(context,
                                                '/pembiayaan_modal_screen');
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                              height: _screen
                                                                      .heightDefault(
                                                                          context) /
                                                                  100),
                                                          Center(
                                                            child: Text(
                                                              "Silahkan Daftar menjadi member dahulu. Fasilitas ini hanya dapat digunakan oleh member Aktif Alhikmah",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CustomButtonRaised(
                                                                  title:
                                                                      'Cancel',
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  isCompleted:
                                                                      true,
                                                                )
                                                              ]),
                                                          SizedBox(
                                                              height: _screen
                                                                      .heightDefault(
                                                                          context) /
                                                                  120),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              _screen.widthDefault(context) /
                                                  65),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/icon/ic_main_pembiayaan.png'),
                                              SizedBox(
                                                  width: _screen.widthDefault(
                                                          context) /
                                                      60),
                                              Text(
                                                'Pembiayaan',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors
                                                                .MORTAR)),
                                              ),
                                              Text('0',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 10,
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                              CustomColors
                                                                  .MORTAR)))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    else
                      return Container(
                        width: 0,
                        height: 0,
                      );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void didInitState() {
    _timeString = _formatDateTime(DateTime.now());
    _clockTimer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  _getTimeDivision() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = DateFormat('KK').format(now);
    var time = int.parse(formattedDateTime);
    if (time >= 0 && time <= 3) {
      _time = 'Selamat istirahat';
    } else if (time >= 4 && time <= 9) {
      _time = 'Selamat beraktifitas';
    } else if (time >= 10 && time <= 13) {
      _time = 'Selamat beraktifitas';
    } else if (time >= 14 && time <= 18) {
      _time = 'Selamat beraktifitas';
    } else if (time >= 19 && time <= 23) {
      _time = 'Selamat beraktifitas';
    }
  }

  _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('kk:mm').format(dateTime);
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }
}
