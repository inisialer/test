part of 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_screen.dart';

class _ItemRecentPulsaPrabayarPhone extends StatelessWidget {
  final ItemRecentPulsaPrabayarPhoneDatum item;

  _ItemRecentPulsaPrabayarPhone({Key key, this.item}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            )
          ]),
      padding: EdgeInsets.symmetric(
          horizontal: _screen.widthDefault(context) / 24,
          vertical: _screen.heightDefault(context) / 64),
      margin: EdgeInsets.only(bottom: _screen.heightDefault(context) / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.phoneNumber,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: AppUtil().parseHexColor(CustomColors.NOBEL)),
          ),
          /*Image.asset(
            'assets/image/img_operator_telkomsel.png',
            width: _screen.widthDefault(context) / 8,
            height: _screen.heightDefault(context) / 24,
          ),*/
        ],
      ),
    );
  }
}
