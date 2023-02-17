part of 'package:alhikmah_app/screen/main/menu/transaction/transaction_screen.dart';

class _DialogSortTransaction extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String sortBy;

  const _DialogSortTransaction(
      {Key key, this.startDate, this.endDate, this.sortBy})
      : super(key: key);

  @override
  __DialogSortTransactionState createState() => __DialogSortTransactionState();
}

class __DialogSortTransactionState extends State<_DialogSortTransaction> {
  PaymentBloc _paymentBloc;
  String _selectedSort = '';
  final _screen = ScreenUtil();

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.sortBy;
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
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
              'Urutkan berdasarkan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: _screen.heightDefault(context) / 100),
            ListTile(
              leading: Radio<String>(
                value: 'asc',
                groupValue: _selectedSort,
                onChanged: (value) {
                  setState(() {
                    _selectedSort = value;
                  });
                },
              ),
              title: const Text('Paling lama'),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'desc',
                groupValue: _selectedSort,
                onChanged: (value) {
                  setState(() {
                    _selectedSort = value;
                  });
                },
              ),
              title: const Text('Paling baru'),
            ),
            SizedBox(height: _screen.heightDefault(context) / 40),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  if (_selectedSort == widget.sortBy) {
                    MyNavigator.goClose(context);
                  } else {
                    MyNavigator.goClose(context);
                    EasyLoading.show(
                      status: 'Loading...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    _paymentBloc.add(HistoryTransactionEvent(
                        startDate: widget.startDate,
                        endDate: widget.endDate,
                        sortBy: _selectedSort,
                        page: 1,
                        perPage: 10));
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
