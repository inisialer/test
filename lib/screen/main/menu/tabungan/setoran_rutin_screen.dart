import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/tabungan/mutasi_tagihan_model.dart';
import 'package:alhikmah_app/model/tabungan/tabungan_list_model.dart';
import 'package:alhikmah_app/screen/main/menu/tabungan/bayar_setoran_awal_screen.dart';
import 'package:alhikmah_app/service/tabungan/tabungan_list_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';

import '../../../../util/navigator.dart';

class SetoranRutinScreen extends StatefulWidget {
  @override
  State<SetoranRutinScreen> createState() => _SetoranRutinScreenState();
}

class _SetoranRutinScreenState extends State<SetoranRutinScreen> {
  final _screen = ScreenUtil();

  MutationSavingModel _mutationSavingModel = MutationSavingModel();

  @override
  void initState() {
    super.initState();
    getIdData();
  }

  TabunganListModel tabunganListModel;

  getIdData() async {
    TabunganListModel valueTabunganListModel =
        await TabunganListService().getList();

    setState(() {
      tabunganListModel = valueTabunganListModel;
    });

    getData();
  }

  getData() async {
    MutationSavingModel mutationSavingModel = await TabunganListService()
        .getMutasiTabungan(tabunganListModel.data[1].id);

    if (mutationSavingModel != null)
      setState(() {
        _mutationSavingModel = mutationSavingModel;
      });

    print(_mutationSavingModel);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
        title: "Setoran Rutin",
        isLeadingShow: true,
        body: Container(
          margin: EdgeInsets.only(
              left: _screen.widthDefault(context) / 20,
              right: _screen.widthDefault(context) / 20,
              top: _screen.heightDefault(context) / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 16, bottom: 16, left: 23, right: 23),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(48),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saldo Setoran Rutin",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: AppUtil().parseHexColor(
                                      CustomColors.GRANNY_SMITH_APPLE),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            _mutationSavingModel != null
                                ? Text(
                                    _mutationSavingModel.data != null
                                        ? AppUtil().formattedMoneyIDR(
                                            _mutationSavingModel.data.length > 0
                                                ? _mutationSavingModel
                                                    .data[0].balance
                                                : 0)
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppUtil()
                                            .parseHexColor(CustomColors.MORTAR),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700))
                                : Container()
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.visibility_outlined)))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 8, bottom: 28, left: 23, right: 23),
                    decoration: BoxDecoration(
                      color: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Tanggal',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppUtil()
                                            .parseHexColor(CustomColors.MORTAR),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700)),
                                Text('Transaksi',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppUtil()
                                            .parseHexColor(CustomColors.MORTAR),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700)),
                                Text('Nominal',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppUtil()
                                            .parseHexColor(CustomColors.MORTAR),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700)),
                                Text('Saldo',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppUtil()
                                            .parseHexColor(CustomColors.MORTAR),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    _mutationSavingModel?.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  if (_mutationSavingModel != null)
                                    return Container(
                                      padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          left: 16,
                                          right: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(48),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 60,
                                            child: Text(
                                                AppUtil().formattedDateServer(
                                                    _mutationSavingModel
                                                        .data[index].timestamp,
                                                    context),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors
                                                                .MORTAR),
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Container(
                                            width: 60,
                                            child: Text(
                                                _mutationSavingModel
                                                    .data[index].mutationType,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors
                                                                .MORTAR),
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Container(
                                            width: 50,
                                            child: Text(
                                                _mutationSavingModel
                                                    .data[index].nominal
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors
                                                                .MORTAR),
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Container(
                                            width: 60,
                                            child: Text(
                                                _mutationSavingModel
                                                    .data[index].balance
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors
                                                                .MORTAR),
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          )
                                        ],
                                      ),
                                    );
                                  else
                                    return Container();
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 8, bottom: 28, left: 23, right: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _mutationSavingModel.data != null
                        ? Container(
                            width: 140,
                            child: CustomButtonRaised(
                              title: 'Setor Tunai',
                              // isCompleted: _mutationSavingModel.data.length > 0
                              //     ? true
                              //     : false,
                              isCompleted: true,
                              onTap: () async {
                                // bool value = await PembiayaanService()
                                //     .getCapitalReq(capitalLoanModel.data.id,
                                //         tujuanModal.text);
                                // if (value) {
                                //   Navigator.pushNamed(
                                //       context, '/result_pembayaran_screen');
                                // }
                                String value = 'recurring';
                                MyNavigator.bayarSetoran(
                                  context,
                                  BayarSetoranArgs(value: value),
                                );
                              },
                            ),
                          )
                        : Container(),
                    Container(
                      width: 140,
                      child: CustomButtonRaised(
                        title: 'Tarik Tunai',
                        isCompleted: true,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
