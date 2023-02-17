part of 'package:alhikmah_app/screen/start/onboarding/onboarding_screen.dart';

class _ItemOnboarding extends StatelessWidget {
  final int index;
  final OnboardingModel item;
  final SwiperController controller;

  const _ItemOnboarding({Key key, this.index, this.item, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screen = ScreenUtil();

    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Images.LOGO_ALHIKMAH,
                height: _screen.heightDefault(context) / 3.5,
              ),
              Image.asset(
                item.image,
                height: _screen.heightDefault(context) / 2.6,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: _screen.widthDefault(context) / 12,
                    right: _screen.widthDefault(context) / 16),
                child: Text(
                  item.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppUtil().parseHexColor(CustomColors.MORTAR)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: _screen.widthDefault(context) / 12,
                    right: _screen.widthDefault(context) / 16),
                child: Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppUtil().parseHexColor(CustomColors.MORTAR),
                  ),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => {
                  if (index == onboardingList.length - 1)
                    {MyNavigator.goToCheckPhone(context)}
                  else
                    {controller.move(index + 1)}
                },
                child: Container(
                    margin: EdgeInsets.only(
                        bottom: _screen.heightDefault(context) / 30,
                        right: _screen.widthDefault(context) / 16),
                    child: Text(
                      (index == 2) ? 'Selesai' : 'Lanjut',
                      style: TextStyle(
                          color: AppUtil().parseHexColor(CustomColors.AMAZON),
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    )),
              )),
          Visibility(
            visible: index == 1 || index == 2,
            child: Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: () => controller.move(index - 1),
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: _screen.heightDefault(context) / 30,
                          left: _screen.widthDefault(context) / 16),
                      child: Text(
                        'Kembali',
                        style: TextStyle(
                            color: AppUtil().parseHexColor(CustomColors.AMAZON),
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      )),
                )),
          )
        ],
      ),
    );
  }
}
