import 'package:alhikmah_app/bloc/ppob/pulsa/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/ppob/pulsa/item_paket_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/item_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/recent_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/data/payment.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/data/item_phone.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_payment_screen.dart';
import 'package:alhikmah_app/util/app_style.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'package:alhikmah_app/screen/main/ppob/pulsa/widget/custom_textfield_pulsa.dart';
part 'package:alhikmah_app/screen/main/ppob/pulsa/widget/item_paket_data_prabayar.dart';
part 'package:alhikmah_app/screen/main/ppob/pulsa/widget/item_pulsa_prabayar.dart';
part 'package:alhikmah_app/screen/main/ppob/pulsa/widget/item_recent_pulsa_prabayar.dart';

class PulsaPrabayarDetailScreen extends StatefulWidget {
  const PulsaPrabayarDetailScreen({Key key}) : super(key: key);

  @override
  _PulsaPrabayarDetailScreenState createState() =>
      _PulsaPrabayarDetailScreenState();
}

class _PulsaPrabayarDetailScreenState extends State<PulsaPrabayarDetailScreen>
    with SingleTickerProviderStateMixin {
  PulsaPrabayarDetailArguments args;
  TextEditingController _noPhone = TextEditingController();
  TabController _tabController;
  final _screen = ScreenUtil();
  int _currentIndex = 0;
  PulsaBloc _pulsaBloc;
  ItemPulsaPrabayarModel _itemPulsaModel;
  ItemPaketPrabayarModel _itemPaketModel;
  RecentPulsaPrabayarModel _recentPulsaModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
    _pulsaBloc = BlocProvider.of<PulsaBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _pulsaBloc.add(RecentPulsaPrabayarEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    _noPhone.text = args.data.phone;
    if (_itemPulsaModel?.data?.isEmpty ?? true) {
      _pulsaBloc.add(ItemPulsaPrabayarEvent(provider: args.data.provider));
    }
    if (_itemPaketModel?.data?.isEmpty ?? true) {
      _pulsaBloc.add(ItemPaketPrabayarEvent(provider: args.data.provider));
    }

    return BlocListener<PulsaBloc, PulsaState>(
      listener: (context, state) {
        if (state is GetItemPulsaPrabayarSuccessState) {
          EasyLoading.dismiss();
          _itemPulsaModel = state.data;
        } else if (state is GetItemPulsaPrabayarFailedState) {
          EasyLoading.dismiss();
        } else if (state is GetItemPaketPrabayarSuccessState) {
          EasyLoading.dismiss();
          _itemPaketModel = state.data;
        } else if (state is GetItemPaketPrabayarFailedState) {
          EasyLoading.dismiss();
        } else if (state is GetRecentPulsaPrabayarSuccessState) {
          EasyLoading.dismiss();
          _recentPulsaModel = state.data;
        } else if (state is GetRecentPulsaPrabayarFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PulsaBloc, PulsaState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Pulsa',
            body: Container(
              height: double.infinity,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _screen.widthDefault(context) / 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: _screen.heightDefault(context) / 20),
                        CustomText(text: 'No. Telepon'),
                        ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _noPhone,
                            builder: (context, value, child) {
                              return _CustomTextField(
                                controller: _noPhone,
                                logo: args.data.logo,
                                isReadOnly: true,
                                isSuffix: true,
                                function: () {
                                  MyNavigator.goClose(context);
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _screen.heightDefault(context) / 40,
                        left: _screen.widthDefault(context) / 36,
                        right: _screen.widthDefault(context) / 36),
                    child: PreferredSize(
                      preferredSize: Size(
                          double.infinity, _screen.heightDefault(context) / 16),
                      child: Container(
                        height: _screen.heightDefault(context) / 16,
                        child: TabBar(
                            controller: _tabController,
                            unselectedLabelColor:
                                AppUtil().parseHexColor(CustomColors.NOBEL),
                            labelColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                            ),
                            tabs: [
                              Tab(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(48),
                                    color: _currentIndex == 0
                                        ? AppUtil().parseHexColor(
                                            CustomColors.GRANNY_SMITH_APPLE)
                                        : AppUtil().parseHexColor(
                                            CustomColors.WHITE_SMOKE),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Pulsa"),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(48),
                                    color: _currentIndex == 1
                                        ? AppUtil().parseHexColor(
                                            CustomColors.GRANNY_SMITH_APPLE)
                                        : AppUtil().parseHexColor(
                                            CustomColors.WHITE_SMOKE),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Data"),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _recentPulsaModel?.data?.isNotEmpty ?? false,
                      child: SizedBox(
                          height: _screen.heightDefault(context) / 40)),
                  Visibility(
                    visible: _recentPulsaModel?.data?.isNotEmpty ?? false,
                    child: Container(
                      color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
                      width: double.infinity,
                      height: _screen.heightDefault(context) / 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: _screen.widthDefault(context) / 40,
                              left: _screen.widthDefault(context) / 12,
                            ),
                            child: Text(
                              'Terakhir Dibeli',
                              style: descTextStyle,
                            ),
                          ),
                          SizedBox(height: _screen.heightDefault(context) / 80),
                          Expanded(
                            child: ListView.builder(
                                itemCount: _recentPulsaModel?.data?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return _ItemRecentPulsaPrabayar(
                                    item: _recentPulsaModel.data[index],
                                  );
                                }),
                          ),
                          SizedBox(height: _screen.heightDefault(context) / 80),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 32),
                  IndexedStack(
                    index: _currentIndex,
                    children: [
                      Visibility(
                        maintainState: true,
                        visible: _currentIndex == 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: _screen.widthDefault(context) / 16),
                          child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 2.5,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: List.generate(
                                  _itemPulsaModel?.data?.length ?? 0, (index) {
                                return GestureDetector(
                                    onTap: () {
                                      var data = PaymentModel(
                                          no: _noPhone.text,
                                          bill:
                                              _itemPulsaModel.data[index].price,
                                          admin: 0,
                                          total:
                                              _itemPulsaModel.data[index].price,
                                          typeMenu: 'pulsa',
                                          pulsaNo: _noPhone.text,
                                          pulsaCode: _itemPulsaModel
                                              .data[index].productCode,
                                          pulsaType: 'Pulsa',
                                          pulsaDesc: _itemPulsaModel
                                              .data[index].productDesc);
                                      MyNavigator.goToHomePulsaPayment(context,
                                          PulsaPrabayarPaymentArguments(data));
                                    },
                                    child: _ItemPulsaPrabayar(
                                        item: _itemPulsaModel?.data[index]));
                              })),
                        ),
                      ),
                      Visibility(
                        maintainState: true,
                        visible: _currentIndex == 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: _screen.widthDefault(context) / 16),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _itemPaketModel?.data?.length ?? 0,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      var data = PaymentModel(
                                          no: _noPhone.text,
                                          bill:
                                              _itemPaketModel.data[index].price,
                                          admin: 0,
                                          total:
                                              _itemPaketModel.data[index].price,
                                          typeMenu: 'pulsa',
                                          pulsaNo: _noPhone.text,
                                          pulsaCode: _itemPaketModel
                                              .data[index].productCode,
                                          pulsaType: 'Data',
                                          pulsaDesc: _itemPaketModel
                                              .data[index].productDesc);
                                      MyNavigator.goToHomePulsaPayment(context,
                                          PulsaPrabayarPaymentArguments(data));
                                    },
                                    child: _ItemPaketDataPrabayar(
                                        item: _itemPaketModel?.data[index]));
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PulsaPrabayarDetailArguments {
  final ItemPhoneModel data;

  PulsaPrabayarDetailArguments(this.data);
}
