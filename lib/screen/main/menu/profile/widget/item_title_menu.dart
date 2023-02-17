part of 'package:alhikmah_app/screen/main/menu/profile/profile_screen.dart';

class _ItemTitleMenu extends StatelessWidget {
  final String title;

  _ItemTitleMenu({Key key, this.title}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin:
            EdgeInsets.symmetric(horizontal: _screen.widthDefault(context) / 5),
        padding: EdgeInsets.symmetric(
            vertical: _screen.heightDefault(context) / 120,
            horizontal: _screen.widthDefault(context) / 24),
        decoration: BoxDecoration(
            color: AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
    );
  }
}
