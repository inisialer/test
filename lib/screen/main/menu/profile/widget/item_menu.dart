part of 'package:alhikmah_app/screen/main/menu/profile/profile_screen.dart';

class _ItemMenu extends StatelessWidget {
  final String title;
  final Color colorText;

  _ItemMenu({Key key, this.title, this.colorText}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: _screen.heightDefault(context) / 100),
        color: Colors.white,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: colorText ?? AppUtil().parseHexColor(CustomColors.MORTAR)),
        ));
  }
}
