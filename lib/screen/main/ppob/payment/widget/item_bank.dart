part of 'package:alhikmah_app/screen/main/ppob/payment/payment_method_screen.dart';

class _ItemBank extends StatelessWidget {
  final DataBank item;

  _ItemBank({Key key, this.item}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, item);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.only(top: _screen.heightDefault(context) / 100),
        padding: EdgeInsets.symmetric(
            horizontal: _screen.widthDefault(context) / 24,
            vertical: _screen.heightDefault(context) / 100),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                item.bankName == 'Zipay'
                    ? Image.asset(
                        item.bankLogo,
                        width: _screen.widthDefault(context) / 5,
                        height: _screen.heightDefault(context) / 18,
                      )
                    : Image.network(
                        item.bankLogo,
                        width: _screen.widthDefault(context) / 5,
                        height: _screen.heightDefault(context) / 18,
                      ),
                SizedBox(width: _screen.widthDefault(context) / 40),
                Text(
                  item.bankName,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppUtil().parseHexColor(CustomColors.CHARCOAL)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
