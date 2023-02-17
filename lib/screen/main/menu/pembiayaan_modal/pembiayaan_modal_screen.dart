import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/data/lihat_tagihan_model.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/service/capital_loan_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';

class PembiayaanModalScreen extends StatefulWidget {
  @override
  State<PembiayaanModalScreen> createState() => _PembiayaanModalScreenState();
}

class _PembiayaanModalScreenState extends State<PembiayaanModalScreen> {
  LihatTagihanModel lihatTagihanModel = LihatTagihanModel();
  ScreenUtil _screenUtil = ScreenUtil();

  @override
  void initState() {
    getCapitalLoan();
    super.initState();
  }

  Future<LihatTagihanModel> getCapitalLoan() async {
    LihatTagihanModel res = await CapitalLoanService().getCapitalLocanService();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
        title: "Pembiayaan",
        isLeadingShow: true,
        body: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 23, right: 23),
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
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
                    child: FutureBuilder<LihatTagihanModel>(
                        future: getCapitalLoan(),
                        initialData:
                            LihatTagihanModel(data: <DataTagihanList>[]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Text(
                                    'Anda memiliki ${snapshot.data.data.length} tagihan ${snapshot.data.data.length > 0 ? snapshot.data.data[0].status == "waiting" ? "sedang menunggu konfirmasi" : "aktif" : "aktif"}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppUtil()
                                            .parseHexColor(CustomColors.MORTAR),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                if (snapshot.data.data.length > 0)
                                  if (snapshot.data.data[0].status != "waiting")
                                    Container(
                                      margin: EdgeInsets.only(top: 32),
                                      child: CustomButtonOutline(
                                        title: 'Lihat Tagihan',
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              '/tagihan_pembiayaan_screen');
                                        },
                                      ),
                                    )
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Text('Anda memiliki 0 tagihan aktif',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppUtil()
                                            .parseHexColor(CustomColors.MORTAR),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                FutureBuilder<LihatTagihanModel>(
                                    future: getCapitalLoan(),
                                    initialData: LihatTagihanModel(
                                        data: <DataTagihanList>[]),
                                    builder: (context, snapshot) {
                                      if (snapshot.data.data.length > 0) {
                                        return Container(
                                          margin: EdgeInsets.only(top: 32),
                                          child: CustomButtonOutline(
                                            title: 'Lihat Tagihan',
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/tagihan_pembiayaan_screen');
                                            },
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          margin: EdgeInsets.only(top: 32),
                                          child: CustomButtonOutline(
                                            title: 'Lihat Tagihan',
                                            onTap: null,
                                          ),
                                        );
                                      }
                                    })
                              ],
                            );
                          }
                        })),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
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
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(left: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pinjaman Dana Cepat',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppUtil()
                                        .parseHexColor(CustomColors.MORTAR),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            Text(
                              'Fasilitas Pinjaman dengan Jangka Pendek, dari Rp. 500.000 hingga 1.000.000',
                              textAlign: TextAlign.left,
                              maxLines: null,
                              style: TextStyle(
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.SHADY_LADY),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 110,
                            child: CustomButtonRaised(
                              isCompleted: true,
                              title: 'Ajukan Sekarang',
                              onTap: () {
                                AppUtil.customShowDialog(
                                    context: context,
                                    width: _screenUtil.widthDefault(context));
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
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
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(left: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pinjaman Modal',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppUtil()
                                        .parseHexColor(CustomColors.MORTAR),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            Text(
                              'Fasilitas untuk Pinjaman modal usaha dengan pembayaran dicicil per bulan, Nilai dari Rp. 500.000 hingga 3.000.000',
                              textAlign: TextAlign.left,
                              maxLines: null,
                              style: TextStyle(
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.SHADY_LADY),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          FutureBuilder<LihatTagihanModel>(
                              future: getCapitalLoan(),
                              initialData:
                                  LihatTagihanModel(data: <DataTagihanList>[]),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.data.length > 0) {
                                    return Container(
                                      width: 110,
                                      child: CustomButtonRaised(
                                        isCompleted: true,
                                        title: 'Ajukan Sekarang',
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Center(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    width: _screenUtil
                                                            .widthDefault(
                                                                context) *
                                                        0.9,
                                                    child: Wrap(
                                                      runSpacing: 10,
                                                      children: [
                                                        Container(
                                                          width: _screenUtil
                                                              .widthDefault(
                                                                  context),
                                                          child: Text(
                                                            "Pengajuan Tidak Dapat Dilakukan",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: AppUtil()
                                                                    .parseHexColor(
                                                                        CustomColors
                                                                            .PALE_GREEN)),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          width: _screenUtil
                                                              .widthDefault(
                                                                  context),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Maaf anda tidak dapat melakukan pengajuan modal karena masih adanya pengajuan modal yang sedang aktif atau proses",
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                    );
                                  }
                                }

                                return Container(
                                  width: 110,
                                  child: CustomButtonRaised(
                                    isCompleted: true,
                                    title: 'Ajukan Sekarang',
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/pembiayaan_m_screen');
                                    },
                                  ),
                                );
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
