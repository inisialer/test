part of 'package:alhikmah_app/screen/main/ppob/topup/top_up_screen.dart';

class _ItemBank extends StatelessWidget {
  final Datum item;

  _ItemBank({Key key, this.item}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.bankName == 'Zipay') {
          MyNavigator.goToHomeTopUpWallet(context);
        } else {
          //MyNavigator.goToHomePaymentBank(context, PaymentBankArguments(item));
        }
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
          children: [
            Image.network(
              item.bankLogo,
              width: _screen.widthDefault(context) / 5,
              height: _screen.heightDefault(context) / 18,
            ),
            SizedBox(width: _screen.widthDefault(context) / 40),
            Expanded(
              child: Text(
                item.bankName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
