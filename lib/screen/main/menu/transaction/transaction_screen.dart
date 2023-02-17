import 'dart:developer';

import 'package:alhikmah_app/app.dart';
import 'package:alhikmah_app/bloc/auth/bloc.dart';
import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/data/shared_preferences.dart';
import 'package:alhikmah_app/model/payment/history_transaction_model.dart';
import 'package:alhikmah_app/screen/main/menu/transaction/detail_transaction_biller_screen.dart';
import 'package:alhikmah_app/screen/main/menu/transaction/detail_transaction_pulsa_screen.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'package:alhikmah_app/screen/main/menu/transaction/widget/dialog_filter_transaction.dart';

part 'package:alhikmah_app/screen/main/menu/transaction/widget/dialog_sort_transaction.dart';

part 'package:alhikmah_app/screen/main/menu/transaction/widget/item_transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _screen = ScreenUtil();
  PaymentBloc _paymentBloc;
  List<ItemHistoryTransaction> _itemHistoryTransactionModel;
  ScrollController _scrollController;
  int _pageCount = 1;
  int _totalPage = 0;
  String sortBy = 'desc';
  String startDate = '';
  String endDate = '';

  SharedPreferences _prefs = App().sharedPreferences;
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
    EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    if (_prefs.getInt(SharePrefs.EXPIRES_TOKEN) <
        DateTime.now().millisecondsSinceEpoch) {
      _authBloc.add(RefreshTokenEvent(
          refreshToken: _prefs.getString(SharePrefs.REFRESH_TOKEN)));
    } else {
      _paymentBloc.add(HistoryTransactionEvent(
          startDate: startDate,
          endDate: endDate,
          sortBy: sortBy,
          page: 1,
          perPage: 10));
    }
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (_pageCount == _totalPage) {
          EasyLoading.dismiss();
        } else {
          EasyLoading.show(
            status: 'Loading...',
            maskType: EasyLoadingMaskType.black,
          );

          _pageCount = _pageCount + 1;
          _paymentBloc.add(HistoryTransactionEvent(
              startDate: startDate,
              endDate: endDate,
              sortBy: sortBy,
              page: _pageCount,
              perPage: 10));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is HistoryTransactionSuccessState) {
          EasyLoading.dismiss();
          startDate = state.startDate;
          endDate = state.endDate;
          sortBy = state.sortBy;
          if (state.data.data.page == 1) {
            _itemHistoryTransactionModel = null;
            _pageCount = 1;
          }

          if (_itemHistoryTransactionModel == null) {
            _itemHistoryTransactionModel = state.data.data.items;
            _totalPage = state.data.data.totalPage;
          } else {
            _itemHistoryTransactionModel.addAll(state.data.data.items);
          }
        } else if (state is HistoryTransactionFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppUtil().parseHexColor(CustomColors.ALICE_BLUE),
            appBar: AppBar(
              title: Container(
                width: _screen.widthDefault(context),
                child: Text(
                  'Riwayat Transaksi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppUtil().parseHexColor(CustomColors.AMAZON)),
                ),
              ),
              backgroundColor: AppUtil().parseHexColor(CustomColors.ALICE_BLUE),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(_screen.heightDefault(context) / 32),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: _screen.widthDefault(context) / 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _DialogFilterTransaction(
                                  startDate: startDate,
                                  endDate: endDate,
                                  sortBy: sortBy,
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: _screen.widthDefault(context) / 40,
                              right: _screen.widthDefault(context) / 24,
                              top: _screen.heightDefault(context) / 120,
                              bottom: _screen.heightDefault(context) / 120),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            border: Border.all(
                              color: AppUtil().parseHexColor(
                                  CustomColors.GRANNY_SMITH_APPLE),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.filter_list,
                                  color: AppUtil().parseHexColor(
                                      CustomColors.GRANNY_SMITH_APPLE)),
                              SizedBox(
                                  width: _screen.widthDefault(context) / 60),
                              Text(
                                'Filter',
                                style: TextStyle(
                                    color: AppUtil().parseHexColor(
                                        CustomColors.GRANNY_SMITH_APPLE),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: _screen.heightDefault(context) / 100),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _DialogSortTransaction(
                                  startDate: startDate,
                                  endDate: endDate,
                                  sortBy: sortBy,
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: _screen.widthDefault(context) / 40,
                              right: _screen.widthDefault(context) / 24,
                              top: _screen.heightDefault(context) / 120,
                              bottom: _screen.heightDefault(context) / 120),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              border: Border.all(
                                  color: AppUtil().parseHexColor(
                                      CustomColors.GRANNY_SMITH_APPLE))),
                          child: Row(
                            children: [
                              Icon(Icons.sort,
                                  color: AppUtil().parseHexColor(
                                      CustomColors.GRANNY_SMITH_APPLE)),
                              SizedBox(
                                  width: _screen.widthDefault(context) / 60),
                              Text(
                                'Sort',
                                style: TextStyle(
                                    color: AppUtil().parseHexColor(
                                        CustomColors.GRANNY_SMITH_APPLE),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                SizedBox(height: _screen.heightDefault(context) / 100),
                Padding(
                  padding: EdgeInsets.only(
                      top: _screen.heightDefault(context) / 100,
                      bottom: _screen.heightDefault(context) / 6.5),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _ItemTransaction(
                        item: _itemHistoryTransactionModel[index],
                      );
                    },
                    itemCount: _itemHistoryTransactionModel?.length ?? 0,
                  ),
                ),
                Visibility(
                    visible: _itemHistoryTransactionModel?.isEmpty ?? false,
                    child: Center(
                      child: Text(
                        'Belum Ada Transaksi',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppUtil().parseHexColor(CustomColors.NOBEL),
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
