import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';

class ModalSuccess extends StatelessWidget {
  double width;
  String title;
  String description;
  Function onClick;
  String buttonText;
  bool withButton;

  ModalSuccess(
      {Key key,
      this.width,
      this.title,
      this.description,
      this.onClick,
      this.buttonText,
      this.withButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            this.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: width * 0.8,
            child: Wrap(
              children: [
                Text(
                  this.description,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          if (withButton)
            Container(
              margin: EdgeInsets.only(top: 20),
              child: CustomButtonRaised(
                onTap: () {
                  onClick();
                },
                width: double.infinity,
                isCompleted: true,
                title: this.buttonText,
              ),
            )
        ],
      ),
    );
  }
}
