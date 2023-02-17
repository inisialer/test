import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AppUtil {
  static final AppUtil _singleton = AppUtil._internal();

  factory AppUtil() => _singleton;

  AppUtil._internal();

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Future<void> showToast(String message) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Color parseHexColor(String hexColorString) {
    if (hexColorString == null) {
      return null;
    }
    hexColorString = hexColorString.toUpperCase().replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString;
    }
    int colorInt = int.parse(hexColorString, radix: 16);
    return Color(colorInt);
  }

  String formattedMoneyIDR(int money) {
    String value = NumberFormat("###,###,###.##", "id_id").format(money ?? 0);

    final moneyStr = (money ?? 0).toString();
    final moneys = moneyStr.split(".");

    if (moneys.length == 2) {
      if (moneys[1].length == 1 && moneys[1] != "0") {
        value = value + "0";
      }
    }

    return value == "NaN" ? "0" : "Rp $value";
  }

  String dateTimeNow() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(now);

    return formattedDate;
  }

  String formattedDateServer(String date, BuildContext context) {
    var outputDate = '';
    if (date != '') {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date, true);
      var dateLocal = parseDate.toLocal();
      var outputFormat = DateFormat('dd-MM-yyyy hh:mm').format(dateLocal);
      outputDate = outputFormat;
    }
    return outputDate;
  }

  static customShowDialog(
      {BuildContext context,
      double width,
      String title,
      Function() onTap,
      String labelButton}) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              width: width * 0.9,
              child: Wrap(
                runSpacing: 10,
                children: [
                  Center(
                    child: Icon(
                      Icons.info,
                      color: Colors.amber,
                      size: 70,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: width,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      title ?? "Produk sedang dalam proses pengembangan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomButtonRaised(
                      title: labelButton ?? 'Ok',
                      onTap: onTap ??
                          () {
                            Navigator.pop(context);
                          },
                      isCompleted: true,
                    )
                  ]),
                ],
              ),
            ),
          );
        });
  }
}
