part of 'package:alhikmah_app/screen/main/menu/transaction/transaction_screen.dart';

class _DialogFilterTransaction extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String sortBy;

  const _DialogFilterTransaction(
      {Key key, this.startDate, this.endDate, this.sortBy})
      : super(key: key);

  @override
  __DialogFilterTransactionState createState() =>
      __DialogFilterTransactionState();
}

class __DialogFilterTransactionState extends State<_DialogFilterTransaction> {
  TextEditingController _startDateText = TextEditingController();
  TextEditingController _endDateText = TextEditingController();
  DateTime _startDate;
  DateTime _endDate;
  PaymentBloc _paymentBloc;

  final _screen = ScreenUtil();

  @override
  void initState() {
    super.initState();
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
    _startDateText.text = widget.startDate;
    _endDateText.text = widget.endDate;
    if (widget.startDate != '') {
      _startDate = DateFormat('yyyy-MM-dd').parse(widget.startDate);
    }
    if (widget.endDate != '') {
      _endDate = DateFormat('yyyy-MM-dd').parse(widget.endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _screen.heightDefault(context) / 40),
            Text(
              'Dari Tanggal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: _screen.heightDefault(context) / 100),
            GestureDetector(
              onTap: () {
                AppUtil().hideKeyboard(context);
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1960, 1, 1),
                    maxTime: DateTime.now(), onConfirm: (date) {
                  _startDate = date;
                  var startDate = DateFormat('yyyy-MM-dd').format(date);
                  _startDateText.text = startDate.toString();
                }, currentTime: DateTime.now(), locale: LocaleType.id);
              },
              child: Container(
                color: Colors.white,
                child: IgnorePointer(
                  child: CustomTextFieldForm(
                    hintText: 'yyyy-MM-dd',
                    controller: _startDateText,
                    keyboardType: TextInputType.name,
                    isReadOnly: true,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                ),
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            Text(
              'Sampai Tanggal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: _screen.heightDefault(context) / 100),
            GestureDetector(
              onTap: () {
                AppUtil().hideKeyboard(context);
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1960, 1, 1),
                    maxTime: DateTime.now(), onConfirm: (date) {
                  _endDate = date;
                  var endDate = DateFormat('yyyy-MM-dd').format(date);
                  _endDateText.text = endDate.toString();
                }, currentTime: DateTime.now(), locale: LocaleType.id);
              },
              child: Container(
                color: Colors.white,
                child: IgnorePointer(
                  child: CustomTextFieldForm(
                    hintText: 'yyyy-MM-dd',
                    controller: _endDateText,
                    keyboardType: TextInputType.name,
                    isReadOnly: true,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                ),
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  if (_startDateText.text == widget.startDate &&
                      _endDateText.text == widget.endDate) {
                    MyNavigator.goClose(context);
                  } else if (_startDateText.text != '' &&
                      _endDateText.text != '') {
                    if (_startDate.isAfter(_endDate)) {
                      AppUtil.showToast('Rentang waktu tidak sesuai');
                    } else {
                      MyNavigator.goClose(context);
                      EasyLoading.show(
                        status: 'Loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      _paymentBloc.add(HistoryTransactionEvent(
                          startDate: _startDateText.text,
                          endDate: _endDateText.text,
                          sortBy: widget.sortBy,
                          page: 1,
                          perPage: 10));
                    }
                  } else {
                    MyNavigator.goClose(context);
                  }
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                disabledColor:
                    AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
              ),
            )
          ],
        ),
      ),
    );
  }
}
