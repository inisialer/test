import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/app_util.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:flutter/material.dart';

import 'data/list_menu_home.dart';

class DetailHomeScreen extends StatelessWidget {
  DetailHomeScreen({Key key}) : super(key: key);
  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return CustomAppBarDetail(
      title: 'Menu Lainnya',
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
        child: ListView(
          children: [
            GridView.count(
                crossAxisCount: 4,
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: List.generate(menuHomeListMore.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      switch (menuHomeListMore[index].title) {
                        case 'Lainnya':
                          MyNavigator.goToDetailHome(context);
                          break;
                        case 'PDAM':
                          MyNavigator.goToHomePDAM(context);
                          break;
                        case 'Pulsa\nPascabayar':
                          MyNavigator.goToHomePascabayar(context);
                          break;
                        case 'Tagihan\nListrik':
                          MyNavigator.goToHomePlnPascabayar(context);
                          break;
                        case 'BPJS':
                          MyNavigator.goToHomeBPJS(context);
                          break;
                        case 'Pulsa\nPrabayar':
                          MyNavigator.goToHomePulsa(context);
                          break;
                        case 'Top Up':
                          MyNavigator.goToHomeTopUp(context);
                          break;
                        case 'Zakat':
                          MyNavigator.goToHomeZakat(context);
                          break;
                      }
                    },
                    child: Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: _screen.widthDefault(context) / 60,
                            vertical: _screen.heightDefault(context) / 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(menuHomeListMore[index].image),
                            SizedBox(
                                height: _screen.heightDefault(context) / 100),
                            Text(
                              menuHomeListMore[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppUtil().parseHexColor(
                                      CustomColors.GRANNY_SMITH_APPLE),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
