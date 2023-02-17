import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/pembiayaan/capital_loan_model.dart';
import 'package:alhikmah_app/model/pembiayaan/tenor_pembiayaan_model.dart'
    as tenorPembiayaan;
import 'package:alhikmah_app/service/pembiayaan/pembiayaan_service.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/currency_formatter.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:alhikmah_app/widget/custom_dropdown.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:alhikmah_app/widget/custom_text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PembiayaanMScreen extends StatefulWidget {
  @override
  State<PembiayaanMScreen> createState() => _PembiayaanMScreenState();
}

class _PembiayaanMScreenState extends State<PembiayaanMScreen> {
  final _screen = ScreenUtil();
  final _formKey = GlobalKey<FormState>();

  TextEditingController tujuanModal = TextEditingController();
  TextEditingController nilaiModal = TextEditingController();
  TextEditingController bungaPinjaman = TextEditingController();

  TextEditingController biayaLayanan = TextEditingController();

  TextEditingController angsuranPerbulan = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTenor();
  }

  String nominal;
  String loadId;

  tenorPembiayaan.TenorPembiayaanModel tenor;
  CapitalLoanModel capitalLoanModel = CapitalLoanModel();

  getTenor() async {
    var _tenor = await PembiayaanService().getTenor();

    setState(() {
      tenor = _tenor;
    });
  }

  getCalculate() async {
    var data = await PembiayaanService()
        .getCapitalLoan(int.parse(nilaiModal.text), dropdownValue);

    setState(() {
      capitalLoanModel = data;
      bungaPinjaman.text = capitalLoanModel.data.interest.toString();
      biayaLayanan.text = capitalLoanModel.data.serviceFee.toString();
      angsuranPerbulan.text =
          capitalLoanModel.data.monthlyInstallment.toString();
    });
  }

  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
        title: "Pembiayaan Modal",
        isLeadingShow: true,
        body: Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
            child: Container(
              width: _screen.widthDefault(context),
              height: _screen.heightDefault(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Kalkulator Pembiayaan',
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    fontSize: 16,
                  ),
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 32),
                          CustomText(
                            text: 'Tujuan Modal',
                            color: AppUtil().parseHexColor(CustomColors.NOBEL),
                          ),
                          CustomTextFieldForm(
                            keyboardType: TextInputType.name,
                            color: AppUtil().parseHexColor(CustomColors.MORTAR),
                            isAll: true,
                            controller: tujuanModal,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Tujuan modal harus di isi!';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              // _payload.fullName = value;
                              tujuanModal.text = value;
                            },
                          ),
                          SizedBox(height: 16),
                          CustomText(
                            text: 'Nilai Modal',
                            color: AppUtil().parseHexColor(CustomColors.NOBEL),
                          ),
                          CustomTextFieldForm(
                            keyboardType: TextInputType.number,
                            color: AppUtil().parseHexColor(CustomColors.MORTAR),
                            isAll: true,
                            controller: nilaiModal,
                            formatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(maxDigits: 20)
                            ],
                            prefixText: 'Rp. ',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Nilai modal harus di isi!';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              // _payload.fullName = value;
                              nilaiModal.text = value;
                            },
                          ),
                          SizedBox(height: 16),
                          CustomText(
                            text: 'Jangka Waktu',
                            color: AppUtil().parseHexColor(CustomColors.NOBEL),
                          ),
                          tenor != null
                              ? CustomDropdownX(
                                  items: tenor.data
                                      .map((tenorPembiayaan.Data value) {
                                    return DropdownMenuItem<String>(
                                      value: value.id,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                  // item: dropdownValue ?? tenor.data[0].id,
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                      print(dropdownValue);
                                    });

                                    getCalculate();
                                  },
                                  hint: dropdownValue != null
                                      ? dropdownValue + ' Bulan'
                                      : 'Pilih tenor',
                                  color: AppUtil()
                                      .parseHexColor(CustomColors.MORTAR),
                                )
                              : Container(),
                          SizedBox(height: 16),
                          CustomText(
                            text: 'Bunga Pinjaman',
                            color: AppUtil().parseHexColor(CustomColors.NOBEL),
                          ),
                          CustomTextFieldForm(
                            keyboardType: TextInputType.number,
                            color: AppUtil().parseHexColor(CustomColors.MORTAR),
                            formatter: [CurrencyInputFormatter(maxDigits: 20)],
                            isReadOnly: true,
                            isAll: false,
                            controller: bungaPinjaman,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Nilai modal harus di isi!';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              // _payload.fullName = value;
                              nilaiModal.text = value;
                            },
                          ),
                          SizedBox(height: 16),
                          CustomText(
                            text: 'Biaya Layanan',
                            color: AppUtil().parseHexColor(CustomColors.NOBEL),
                          ),
                          CustomTextFieldForm(
                            keyboardType: TextInputType.name,
                            color: AppUtil().parseHexColor(CustomColors.MORTAR),
                            isAll: true,
                            controller: biayaLayanan,
                            isReadOnly: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Biaya layanan harus terisi!';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              // _payload.fullName = value;
                              nilaiModal.text = value;
                            },
                          ),
                          SizedBox(height: 16),
                          CustomText(
                            text: 'Angsuran Perbulan',
                            color: AppUtil().parseHexColor(CustomColors.NOBEL),
                          ),
                          CustomTextFieldForm(
                            keyboardType: TextInputType.name,
                            color: AppUtil().parseHexColor(CustomColors.MORTAR),
                            isAll: true,
                            controller: angsuranPerbulan,
                            isReadOnly: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Angsuran Perbulan harus terisi!';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              // _payload.fullName = value;
                              nilaiModal.text = value;
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                child: CustomButtonRaised(
                                  title: 'Lanjut',
                                  isCompleted: (bungaPinjaman.text.length > 0 &&
                                          biayaLayanan.text.length > 0 &&
                                          angsuranPerbulan.text.length > 0)
                                      ? true
                                      : false,
                                  onTap: () async {
                                    bool value = await PembiayaanService()
                                        .getCapitalReq(capitalLoanModel.data.id,
                                            tujuanModal.text);
                                    if (value) {
                                      Navigator.pushNamed(
                                          context, '/result_pembayaran_screen');
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width: 100,
                                child: CustomButtonOutline(
                                  title: 'Cancel',
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
