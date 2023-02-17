part of 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_detail_screen.dart';

class _ItemPaketDataPrabayar extends StatelessWidget {
  final ItemPaketDatum item;

  _ItemPaketDataPrabayar({Key key, this.item}) : super(key: key);
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: _screen.heightDefault(context) / 40),
        padding: EdgeInsets.symmetric(
            horizontal: _screen.widthDefault(context) / 24,
            vertical: _screen.heightDefault(context) / 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 120),
                  Text(
                    AppUtil().formattedMoneyIDR(item.price),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(width: _screen.widthDefault(context) / 24),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _DialogFilterTransaction(item: item);
                    });
              },
              child: Text(
                'Detail',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppUtil().parseHexColor(CustomColors.DEEP_SKY_BLUE)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DialogFilterTransaction extends StatelessWidget {
  final ItemPaketDatum item;
  final _screen = ScreenUtil();

  _DialogFilterTransaction({Key key, this.item}) : super(key: key);

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => MyNavigator.goClose(context),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset('assets/icon/ic_close.png'),
              ),
            ),
            SizedBox(height: _screen.heightDefault(context) / 100),
            Text(
              item.productName,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: _screen.heightDefault(context) / 120),
            Text(
              'Rp ${AppUtil().formattedMoneyIDR(item.price)}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
