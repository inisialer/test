part of 'package:alhikmah_app/screen/main/ppob/payment/payment_bank_screen.dart';

class _ItemMethodBank extends StatelessWidget {
  final bool isVisible;
  final String title;
  final String desc;

  _ItemMethodBank({Key key, this.title, this.desc, this.isVisible})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                    fontWeight: FontWeight.w800),
              ),
              Image.asset(
                  isVisible
                      ? 'assets/icon/ic_arrow_top.png'
                      : 'assets/icon/ic_arrow_down.png',
                  color:
                      AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE))
            ],
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                right: _screen.widthDefault(context) / 24,
                top: _screen.heightDefault(context) / 120,
                bottom: _screen.widthDefault(context) / 40),
            child: Text(
              desc,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
