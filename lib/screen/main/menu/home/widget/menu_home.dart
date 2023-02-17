part of 'package:alhikmah_app/screen/main/menu/home/home_screen.dart';

class _MenuHome extends StatelessWidget {
  _MenuHome({Key key}) : super(key: key);

  final _screen = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: GridView.count(
          crossAxisCount: 4,
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: List.generate(menuHomeList.length, (index) {
            return GestureDetector(
              onTap: () {
                switch (menuHomeList[index].title) {
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
                  case 'Token\nListrik':
                    MyNavigator.goToHomePlnPrabayar(context);
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
                      Image.asset(menuHomeList[index].image),
                      SizedBox(height: _screen.heightDefault(context) / 100),
                      Text(
                        menuHomeList[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppUtil()
                                .parseHexColor(CustomColors.GRANNY_SMITH_APPLE),
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
            );
          })),
    );
  }
}
