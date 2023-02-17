part of 'package:alhikmah_app/screen/main/ppob/payment/payment_status_screen.dart';

class _ItemDataStatus extends StatelessWidget {
  final String data;
  final String title;

  _ItemDataStatus({Key key, this.data, this.title}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (data != '') ? true : false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: descTextStyle),
          Text(data, style: titleTextStyle),
          SizedBox(height: _screen.heightDefault(context) / 100),
        ],
      ),
    );
  }
}
