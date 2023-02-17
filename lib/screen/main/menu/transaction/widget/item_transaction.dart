part of 'package:alhikmah_app/screen/main/menu/transaction/transaction_screen.dart';

class _ItemTransaction extends StatelessWidget {
  final ItemHistoryTransaction item;

  _ItemTransaction({Key key, this.item}) : super(key: key);

  var waiting = [
    "waiting",
    "waiting-confirmation",
    "waiting-paid",
    'submitted'
  ];
  var success = ["success", "done", "success", "closed"];

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    log(item.toJson().toString());
    return GestureDetector(
      onTap: () {
        if (item.transactionType == 'pulsa-prabayar') {
          MyNavigator.goToDetailTransactionPulsa(
              context, DetailTransactionPulsaArguments(item));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailTransactionBillerScreen(
                      args: DetailTransactionBillerArguments(item))));
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: _screen.heightDefault(context) / 100,
            left: _screen.widthDefault(context) / 24,
            right: _screen.widthDefault(context) / 24),
        padding: EdgeInsets.only(
            left: _screen.widthDefault(context) / 16,
            right: _screen.widthDefault(context) / 40,
            top: _screen.heightDefault(context) / 100,
            bottom: _screen.heightDefault(context) / 120),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(45)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.transactionTitle,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 180),
                  Text(
                    double.tryParse(item.transactionDesc1) != null
                        ? '${item.transactionTitle}'
                        : '${item.transactionDesc1}',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 180),
                  // Text(
                  //   '${item.transactionDesc2}',
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w800,
                  //       fontSize: 12,
                  //       color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                  // ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                AppUtil()
                    .formattedDateServer(item.transactionTimestamp, context),
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                textAlign: TextAlign.end,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                    top: _screen.heightDefault(context) / 200,
                    left: _screen.widthDefault(context) / 32),
                child: Image.asset(
                  (success.contains(item.status)
                      ? 'assets/icon/ic_done_transaksi.png'
                      : waiting.contains(item.status)
                          ? 'assets/icon/ic_waiting_transaksi.png'
                          : 'assets/icon/ic_failed_transaksi.png'),
                  width: _screen.heightDefault(context) / 14,
                  height: _screen.widthDefault(context) / 8,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
