import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/bloc/tabungan_list/tabungan_list_bloc.dart';
import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/bloc/user/user_state.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/model/memberregistration/registration_status_model.dart';
import 'package:alhikmah_app/model/payment/item_va_bank.dart';
import 'package:alhikmah_app/screen/main/menu/tabungan/widget/item_bank_tabungan_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../bloc/user/user_bloc.dart';

class BayarSetoranAwalscreen extends StatefulWidget {
  final BayarSetoranArgs bayarSetoranArgs;

  BayarSetoranAwalscreen({this.bayarSetoranArgs});

  @override
  State<BayarSetoranAwalscreen> createState() => _BayarSetoranAwalscreenState();
}

class _BayarSetoranAwalscreenState extends State<BayarSetoranAwalscreen> {
  final _screen = ScreenUtil();
  PaymentBloc _paymentBloc;
  ItemVaBankModel _itemListBankModel;
  TabunganListBloc tabunganListBloc = TabunganListBloc();
  UserBloc _userBloc;

  bool isHaveMoney = false;
  String transactionID;

  var _itemZipay =
      DataBank(bankLogo: 'assets/image/img_bank_zipay.png', bankName: 'Zipay');

  @override
  void initState() {
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);

    _userBloc.add(BalanceEvent(state: "home"));
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    BayarSetoranArgs args = ModalRoute.of(context).settings.arguments;
    return MultiBlocListener(
        listeners: [
          BlocListener<PaymentBloc, PaymentState>(listener: (context, state) {
            if (state is GetVaBankSuccessState) {
              _itemListBankModel = state.data;
              if (args.isTagihan != true) {
                if (args?.value != null) {
                  tabunganListBloc
                      .add(TabunganCheckPayment(savingType: args.value));
                } else {
                  tabunganListBloc
                      .add(TabunganCheckPayment(savingType: 'initial'));
                }
              } else {
                tabunganListBloc
                    .add(PostTagihanResponseInquiry(id: args.value));
              }
            } else if (state is GetVaBankFailedState) {
              print("Failed");
            }
          }),
          BlocListener<UserBloc, UserState>(listener: (context, state) {
            if (state is GetBalanceSuccessState) {
              EasyLoading.show(
                status: 'Loading...',
                maskType: EasyLoadingMaskType.black,
              );
              isHaveMoney = state.data.data.balance > 0;
              _paymentBloc.add(VaBankEvent());
            } else if (state is GetBalanceFailedState) {
              isHaveMoney = false;
              print("object");
            }
          }),
        ],
        child: CustomAppBarDetail(
            title: 'Metode Pembayaran',
            body: Padding(
                padding: EdgeInsets.only(
                    top: _screen.heightDefault(context) / 100,
                    left: _screen.widthDefault(context) / 16,
                    right: _screen.widthDefault(context) / 16),
                child: SingleChildScrollView(
                  child: BlocConsumer<TabunganListBloc, TabunganListState>(
                    bloc: tabunganListBloc,
                    listener: (context, state) {
                      if (state is TabunganListError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      int nominal = 0;
                      if (state is TabunganListLoaded) {}
                      if (state is TabunganCheckPaymentLoaded) {
                        EasyLoading.dismiss();
                        print(
                            state.checkTagihanSavingModel?.data?.transactionId);
                        if (state
                                .checkTagihanSavingModel?.data?.transactionId !=
                            null) {
                          transactionID =
                              state.checkTagihanSavingModel.data.transactionId;
                          nominal = state.checkTagihanSavingModel.data.bill;
                        } else {
                          print("transactionIdnull");
                        }
                      }
                      if (state is TagihanInquiryPaymentLoaded) {
                        EasyLoading.dismiss();
                        nominal = state.responseTagihanInquiry.data.nominal;
                        transactionID =
                            state.responseTagihanInquiry.data.transactionId;
                      }

                      return Container(
                        width: _screen.widthDefault(context),
                        constraints: BoxConstraints(
                          minHeight: _screen.heightDefault(context),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: _screen.widthDefault(context),
                              margin: EdgeInsets.only(bottom: 28),
                              padding: EdgeInsets.only(
                                  top: 28, bottom: 28, left: 23, right: 23),
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
                              child: Column(
                                children: [
                                  Text(
                                      args.isTagihan == true
                                          ? 'Nominal Tagihan Modal'
                                          : args.value == "recurring"
                                              ? 'Nominal Setoran Rutin'
                                              : 'Nominal Setoran Awal',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppUtil().parseHexColor(
                                              CustomColors.SILVER),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(AppUtil().formattedMoneyIDR(nominal),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppUtil().parseHexColor(
                                              CustomColors.GRANNY_SMITH_APPLE),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ),
                            ItemBankTabungan(
                              item: _itemZipay,
                              transaksiId: transactionID,
                              typeTransaksi: "saving_type",
                              isTagihan: args.isTagihan,
                              isSaldoAda: isHaveMoney,
                            ),
                            SizedBox(
                                height: _screen.heightDefault(context) / 24),
                            CustomText(text: 'Bank Transfer'),
                            ListView.builder(
                                itemCount:
                                    _itemListBankModel?.data?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ItemBankTabungan(
                                    item: _itemListBankModel?.data[index],
                                    transaksiId: transactionID,
                                    typeTransaksi: "saving_type",
                                    isTagihan: args.isTagihan,
                                    isSaldoAda: false,
                                  );
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ))));
  }
}

class BayarSetoranArgs {
  RegistrationStatusModel registModel;
  final String value;
  final bool isTagihan;

  BayarSetoranArgs({this.registModel, this.value, this.isTagihan: false});
}

//
// class BayarSetoranAwalscreen extends StatefulWidget {
//   final BayarSetoranArgs bayarSetoranArgs;
//
//   BayarSetoranAwalscreen({this.bayarSetoranArgs});
//
//   @override
//   State<BayarSetoranAwalscreen> createState() => _BayarSetoranAwalscreenState();
// }
//
// class _BayarSetoranAwalscreenState extends State<BayarSetoranAwalscreen> {
//   final _screen = ScreenUtil();
//   PaymentBloc _paymentBloc;
//   ItemVaBankModel _itemListBankModel;
//   TabunganListBloc tabunganListBloc = TabunganListBloc();
//   UserBloc _userBloc;
//
//   String transaksiID = '';
//
//
//   @override
//   void initState() {
//     super.initState();
//     _paymentBloc = BlocProvider.of<PaymentBloc>(context);
//     _userBloc = BlocProvider.of<UserBloc>(context);
//     EasyLoading.show(
//       status: 'Loading...',
//       maskType: EasyLoadingMaskType.black,
//     );
//     _userBloc.add(BalanceEvent(state: 'home'));
//
//     EasyLoading.show(
//       status: 'Loading...',
//       maskType: EasyLoadingMaskType.black,
//     );
//     _paymentBloc.add(VaBankEvent());
//   }
//
//   var _itemZipay =
//       DataBank(bankLogo: 'assets/image/img_bank_zipay.png', bankName: 'Zipay');
//
//   @override
//   Widget build(BuildContext context) {
//     BayarSetoranArgs args = ModalRoute.of(context).settings.arguments;
//
//     if (args.isTagihan != true) {
//       if (args?.value != null) {
//         tabunganListBloc.add(TabunganCheckPayment(savingType: args.value));
//       } else {
//         tabunganListBloc.add(TabunganCheckPayment(savingType: 'initial'));
//       }
//     } else {
//       tabunganListBloc.add(PostTagihanResponseInquiry(id: args.value));
//     }
//
//     return BlocListener<PaymentBloc, PaymentState>(
//       listener: (context, state) {
//         if (state is GetVaBankSuccessState) {
//           EasyLoading.dismiss();
//           _itemListBankModel = state.data;
//         } else if (state is GetVaBankFailedState) {
//           EasyLoading.dismiss();
//         }
//       },
//       child: BlocBuilder<PaymentBloc, PaymentState>(
//         builder: (context, state) {
//           return CustomAppBarDetail(
//             title: 'Metode Pembayaran',
//             body: Padding(
//               padding: EdgeInsets.only(
//                   top: _screen.heightDefault(context) / 100,
//                   left: _screen.widthDefault(context) / 16,
//                   right: _screen.widthDefault(context) / 16),
//               child: ListView(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(bottom: 28),
//                     padding: EdgeInsets.only(
//                         top: 28, bottom: 28, left: 23, right: 23),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 1,
//                           blurRadius: 2,
//                           offset: Offset(0, 1),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Text(
//                             args.isTagihan == true
//                                 ? 'Nominal Tagihan Modal'
//                                 : args.value == "recurring"
//                                     ? 'Nominal Setoran Rutin'
//                                     : 'Nominal Setoran Awal',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 color: AppUtil()
//                                     .parseHexColor(CustomColors.SILVER),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700)),
//                         SizedBox(
//                           height: 4,
//                         ),
//                         BlocConsumer<TabunganListBloc, TabunganListState>(
//                           bloc: tabunganListBloc,
//                           listener: (context, state) {
//                             if (state is TabunganListLoaded) {}
//                             if (state is TabunganCheckPaymentLoaded) {
//                               print(state
//                                   .checkTagihanSavingModel?.data.transactionId);
//
//                               if (state.checkTagihanSavingModel?.data
//                                       .transactionId !=
//                                   null) {
//                                 // setState(() {
//                                 transaksiID = state
//                                     .checkTagihanSavingModel.data.transactionId;
//                                 // });
//                               } else {
//                                 print("transactionIdnull");
//                               }
//                             }
//                             if (state is TagihanInquiryPaymentLoaded) {
//                               // setState(() {
//                               transaksiID = state
//                                   .responseTagihanInquiry.data.transactionId;
//                               // });
//                             }
//                             if (state is TabunganListError) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text(state.error)),
//                               );
//                             }
//                           },
//                           builder: (context, state) {
//                             if (state is TabunganCheckPaymentLoaded)
//                               return Text(
//                                   AppUtil().formattedMoneyIDR(
//                                       state.checkTagihanSavingModel.data.bill state
// //                                       .responseTagihanInquiry.data.nominal),
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       color: AppUtil().parseHexColor(
//                                           CustomColors.GRANNY_SMITH_APPLE),
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w700));
//                             else if (state is TagihanInquiryPaymentLoaded) {
//                               return Text(
//                                   AppUtil().formattedMoneyIDR(state
//                                       .responseTagihanInquiry.data.nominal),
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       color: AppUtil().parseHexColor(
//                                           CustomColors.GRANNY_SMITH_APPLE),
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w700));
//                             } else
//                               return Container();
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: _screen.heightDefault(context) / 100),
//                   BlocConsumer<UserBloc, UserState>(
//                     listener: (context, state) {
//                       // TODO: implement listener
//                       if (state is GetBalanceSuccessState) {
//                         EasyLoading.dismiss();
//
//                         print("object");
//                       } else if (state is GetBalanceFailedState) {
//                         EasyLoading.dismiss();
//                         print("object");
//                       }
//                     },
//                     builder: (context, state) {
//                       if (state is GetBalanceSuccessState) {
//                         if (state.data.data.balance > 0)
//                           return ItemBankTabungan(
//                             item: _itemZipay,
//                             transaksiId: transaksiID,
//                             typeTransaksi: "saving_type",
//                             isTagihan: args.isTagihan,
//                             isSaldoAda: true,
//                           );
//                         else
//                           return ItemBankTabungan(
//                             item: _itemZipay,
//                             transaksiId: transaksiID,
//                             typeTransaksi: "saving_type",
//                             isTagihan: args.isTagihan,
//                             isSaldoAda: false,
//                           );
//                       } else {
//                         return ItemBankTabungan(
//                           item: _itemZipay,
//                           transaksiId: transaksiID,
//                           typeTransaksi: "saving_type",
//                           isTagihan: args.isTagihan,
//                           isSaldoAda: false,
//                         );
//                       }
//                     },
//                   ),
//                   SizedBox(height: _screen.heightDefault(context) / 24),
//                   CustomText(text: 'Bank Transfer'),
//                   ListView.builder(
//                       itemCount: _itemListBankModel?.data?.length ?? 0,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         return ItemBankTabungan(
//                           item: _itemListBankModel?.data[index],
//                           transaksiId: transaksiID,
//                           typeTransaksi: "saving_type",
//                           isTagihan: args.isTagihan,
//                           isSaldoAda: false,
//                         );
//                       }),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
