part of 'package:alhikmah_app/screen/main/menu/notification/notification_screen.dart';

class _ItemNotification extends StatefulWidget {
  final ItemNotificationModel item;
  final bool isVisible;

  const _ItemNotification({Key key, this.item, this.isVisible})
      : super(key: key);

  @override
  __ItemNotificationState createState() => __ItemNotificationState();
}

class __ItemNotificationState extends State<_ItemNotification> {
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          MyNavigator.goToDetailNotification(
              context, DetailNotificationArguments(widget.item));
          widget.item.isRead = true;
        });
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: _screen.heightDefault(context) / 100,
            left: _screen.widthDefault(context) / 24,
            right: _screen.widthDefault(context) / 24),
        padding: EdgeInsets.symmetric(
            horizontal: _screen.widthDefault(context) / 24),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            gradient: LinearGradient(
                colors: (widget.item.isRead)
                  ? [
                  Colors.white,
                  Colors.white,
                  ]
                  : [
                  AppUtil().parseHexColor(CustomColors.PALE_GREEN),
              AppUtil()
                  .parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
              ]),
          borderRadius: BorderRadius.circular(45)),
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _screen.widthDefault(context) / 40,
              vertical: _screen.heightDefault(context) / 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: (widget.item.isRead)
                              ? AppUtil()
                              .parseHexColor(CustomColors.SHADY_LADY)
                              : AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                    Text(
                      widget.item.date,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: (widget.item.isRead)
                              ? AppUtil()
                              .parseHexColor(CustomColors.SHADY_LADY)
                              : AppUtil().parseHexColor(CustomColors.MORTAR)),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: widget.isVisible,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.item.isChecked = !widget.item.isChecked;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:
                      AppUtil().parseHexColor(CustomColors.SHADY_LADY)),
                  child: Padding(
                      padding:
                          EdgeInsets.all(_screen.heightDefault(context) / 120),
                      child: widget.item.isChecked
                          ? Container(
                              width: _screen.widthDefault(context) / 24,
                              height: _screen.heightDefault(context) / 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: LinearGradient(colors: [
                                  AppUtil()
                                      .parseHexColor(CustomColors.PALE_GREEN),
                                  AppUtil().parseHexColor(
                                      CustomColors.GRANNY_SMITH_APPLE),
                                ]),
                              ),
                            )
                          : Container(
                              width: _screen.widthDefault(context) / 24,
                              height: _screen.heightDefault(context) / 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: AppUtil()
                                    .parseHexColor(CustomColors.SHADY_LADY),
                              ),
                            ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),);
  }
}
