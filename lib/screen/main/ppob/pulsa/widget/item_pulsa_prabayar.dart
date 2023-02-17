part of 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_detail_screen.dart';

class _ItemPulsaPrabayar extends StatelessWidget {
  final ItemPulsaPrabayarDatum item;

  _ItemPulsaPrabayar({Key key, this.item}) : super(key: key);
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: _screen.widthDefault(context) / 24,
          bottom: _screen.heightDefault(context) / 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        border: Border.all(
            color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.productName,
            style: TextStyle(
                color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          Text(
            AppUtil().formattedMoneyIDR(item.price),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}
