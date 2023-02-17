import 'package:after_init/after_init.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'data/list_onboarding.dart';

part 'package:alhikmah_app/screen/start/onboarding/widget/item_onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with AfterInitMixin<OnboardingScreen> {
  SwiperController _controller = SwiperController();
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.BACKGROUND_ONBOARDING),
                fit: BoxFit.cover)),
        child: Center(
          child: Swiper.children(
            index: 0,
            autoplay: false,
            loop: false,
            pagination: SwiperPagination(
              margin:
              EdgeInsets.only(bottom: _screen.heightDefault(context) / 30),
              builder: DotSwiperPaginationBuilder(
                color: AppUtil().parseHexColor(CustomColors.SILVER),
                activeColor:
                    AppUtil().parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                size: 10.0,
                activeSize: 10.0,
              ),
            ),
            control: SwiperControl(
              iconNext: null,
              iconPrevious: null,
            ),
            controller: _controller,
            children: _buildPage(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPage(BuildContext context) {
    List<Widget> widgets = [];
    for (int index = 0; index < onboardingList.length; index++) {
      OnboardingModel intro = onboardingList[index];
      widgets.add(
        _ItemOnboarding(
          index: index,
          item: intro,
          controller: _controller,
        ),
      );
    }
    return widgets;
  }

  @override
  void didInitState() {
    AppUtil().hideKeyboard(context);
  }
}
