part of 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_detail_screen.dart';

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isReadOnly;
  final bool isSuffix;
  final String logo;
  final TextInputAction textInputAction;
  final Function function;

  _CustomTextField(
      {Key key,
      this.controller,
      this.isReadOnly,
      this.isSuffix,
      this.textInputAction,
      this.function,
      this.logo})
      : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly ?? false,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      textInputAction: textInputAction ?? TextInputAction.go,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: AppUtil().parseHexColor(CustomColors.NOBEL)),
      decoration: InputDecoration(
        suffix: (isSuffix ?? true) && controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () => function(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      logo,
                      height: _screen.heightDefault(context) / 30,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(width: _screen.widthDefault(context) / 40),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color:
                              AppUtil().parseHexColor(CustomColors.SHADY_LADY),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: _screen.widthDefault(context) / 38,
                      ),
                    ),
                  ],
                ))
            : null,
        filled: true,
        isDense: true,
        fillColor: AppUtil().parseHexColor(CustomColors.WHITE_SMOKE),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(48),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(48),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: _screen.widthDefault(context) / 24,
            vertical: _screen.heightDefault(context) / 64),
      ),
    );
  }
}
