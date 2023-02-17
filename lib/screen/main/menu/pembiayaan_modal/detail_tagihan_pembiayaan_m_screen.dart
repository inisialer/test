import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/data/detail_tagihan_head_model.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/data/detail_tagihan_model.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/service/capital_loan_service.dart';
import 'package:alhikmah_app/screen/main/menu/tabungan/bayar_setoran_awal_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPembiayaanModalArgs {
  DetailPembiayaanModalArgs({this.id});
  String id;
}

class DetailPembiayaanModal extends StatefulWidget {
  const DetailPembiayaanModal({this.id}) : super();
  final String id;

  @override
  State<DetailPembiayaanModal> createState() => _DetailPembiayaanModalState();
}

class _DetailPembiayaanModalState extends State<DetailPembiayaanModal> {
  final _screen = ScreenUtil();

  Future<DetailTagihanHeadModel> getDetailTagihanHead(String id) async {
    DetailTagihanHeadModel res =
        await CapitalLoanService().lihatTagihanHeadDetail(id);

    return res;
  }

  Future<DetailTagihanModel> getDetail(String id) async {
    DetailTagihanModel res = await CapitalLoanService().lihatTagihanDetail(id);

    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    DetailPembiayaanModalArgs args = ModalRoute.of(context).settings.arguments;
    print(args);
    return CustomAppBarDetail(
        title: "Detail Tagihan",
        isLeadingShow: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                FutureBuilder<DetailTagihanHeadModel>(
                    future: getDetailTagihanHead(args.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rincian Pembiayaan Pembelian",
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Tenor',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors.MORTAR)
                                                        .withOpacity(0.5),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                snapshot.data.data.tenor
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
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Jumlah Pembiayaan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors.MORTAR)
                                                        .withOpacity(0.5),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                AppUtil().formattedMoneyIDR(
                                                    snapshot
                                                        .data.data.totalValue),
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
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Jumlah Terbayar',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors.MORTAR)
                                                        .withOpacity(0.5),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                AppUtil().formattedMoneyIDR(
                                                    snapshot
                                                        .data.data.valuePaid),
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
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Sisa Pembiayaan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors.MORTAR)
                                                        .withOpacity(0.5),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                AppUtil().formattedMoneyIDR(
                                                    snapshot.data.data
                                                        .remainingPayment),
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
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      } else
                        return Container();
                    }),
                FutureBuilder<DetailTagihanModel>(
                    future: getDetail(args.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 16, bottom: 16, left: 2, right: 2),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rincian Pembayaran",
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
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Text('Tenor',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors.MORTAR)
                                                        .withOpacity(0.5),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data.data.length,
                                                itemBuilder: (context, index) =>
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          snapshot.data.data[index].name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: AppUtil()
                                                                  .parseHexColor(
                                                                      CustomColors
                                                                          .MORTAR),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Text('Tagihan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors.MORTAR)
                                                        .withOpacity(0.5),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data.data.length,
                                                itemBuilder: (context, index) =>
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          AppUtil()
                                                              .formattedMoneyIDR(
                                                                  snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .bill),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: AppUtil()
                                                                  .parseHexColor(
                                                                      CustomColors
                                                                          .MORTAR),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Text('Jatuh Tempo',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors.MORTAR)
                                                        .withOpacity(0.5),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data.data.length,
                                                itemBuilder: (context, index) =>
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          DateFormat(
                                                                  'dd-M-yyyy')
                                                              .format(DateTime
                                                                  .parse(
                                                            snapshot
                                                                .data
                                                                .data[index]
                                                                .dueDate,
                                                          )),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: AppUtil()
                                                                  .parseHexColor(
                                                                      CustomColors
                                                                          .MORTAR),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Text('Tanggal Pembayaran',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppUtil()
                                                        .parseHexColor(
                                                            CustomColors.MORTAR)
                                                        .withOpacity(0.5),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data.data.length,
                                                itemBuilder: (context, index) =>
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .payment !=
                                                                  null
                                                              ? DateFormat(
                                                                      'dd-M-yyyy')
                                                                  .format(
                                                                      DateTime
                                                                          .parse(
                                                                  snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .payment,
                                                                ))
                                                              : "-",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: AppUtil()
                                                                  .parseHexColor(
                                                                      CustomColors
                                                                          .MORTAR),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      else
                        return Container();
                    }),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: _screen.widthDefault(context) / 24,
                  right: _screen.widthDefault(context) / 24,
                  top: _screen.heightDefault(context) / 40,
                  bottom: 32),
              child: GestureDetector(
                onTap: () {
                  MyNavigator.bayarSetoran(
                    context,
                    BayarSetoranArgs(value: args.id, isTagihan: true),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(_screen.widthDefault(context) / 24),
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
                      'Bayar Sekarang',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
