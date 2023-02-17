part of 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_detail_screen.dart';

class _ItemRecentPulsaPrabayar extends StatelessWidget {
  final ItemRecentPulsaPrabayarDatum item;

  _ItemRecentPulsaPrabayar({Key key, this.item}) : super(key: key);
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screen.heightDefault(context) / 12,
      width: _screen.widthDefault(context) / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(48),
      ),
      margin: EdgeInsets.only(right: _screen.widthDefault(context) / 24),
      padding:
          EdgeInsets.symmetric(horizontal: _screen.widthDefault(context) / 20),
      child: Row(
        children: [
          Image.network(
            item.providerPic,
            height: _screen.heightDefault(context) / 12,
            width: _screen.widthDefault(context) / 12,
          ),
          SizedBox(width: _screen.widthDefault(context) / 40),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.phoneNumber,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppUtil().parseHexColor(CustomColors.NOBEL)),
                ),
                Text('${item.productType} - ${item.productName}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppUtil().parseHexColor(CustomColors.NOBEL)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
