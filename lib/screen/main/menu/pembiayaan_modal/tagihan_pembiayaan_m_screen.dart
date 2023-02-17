import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/data/lihat_tagihan_model.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/detail_tagihan_pembiayaan_m_screen.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/service/capital_loan_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TagihanPembiyaanScreen extends StatefulWidget {
  @override
  State<TagihanPembiyaanScreen> createState() => _TagihanPembiyaanScreenState();
}

class _TagihanPembiyaanScreenState extends State<TagihanPembiyaanScreen> {
  Future<LihatTagihanModel> getCapitalLoan() async {
    LihatTagihanModel res = await CapitalLoanService().getCapitalLocanService();

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
        title: "Tagihan",
        isLeadingShow: true,
        body: Column(
          children: [
            FutureBuilder<LihatTagihanModel>(
                future: getCapitalLoan(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              MyNavigator.goToDetailPembiayaanModal(
                                  context,
                                  DetailPembiayaanModalArgs(
                                      id: snapshot.data.data[index].id
                                          .toString()));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 16, bottom: 16, left: 16, right: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 23, right: 23),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 16, left: 8, right: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          snapshot
                                              .data.data[index].capitalPurpose,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppUtil().parseHexColor(
                                                  CustomColors.MORTAR),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text('Tenor',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                              CustomColors
                                                                  .MORTAR)
                                                          .withOpacity(0.5),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  snapshot.data.data[index]
                                                      .tenorValue
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                              CustomColors
                                                                  .MORTAR),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text('Tagihan',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                              CustomColors
                                                                  .MORTAR)
                                                          .withOpacity(0.5),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  AppUtil().formattedMoneyIDR(
                                                      snapshot.data.data[index]
                                                          .monthlyInstallment),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                              CustomColors
                                                                  .MORTAR),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text('Jatuh Tempo',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                              CustomColors
                                                                  .MORTAR)
                                                          .withOpacity(0.5),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  DateFormat('dd-M-yyyy')
                                                      .format(DateTime.parse(
                                                          snapshot
                                                              .data
                                                              .data[index]
                                                              .disbursedAt)),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppUtil()
                                                          .parseHexColor(
                                                              CustomColors
                                                                  .MORTAR),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  else
                    return Container();
                }),
          ],
        ));
  }
}
