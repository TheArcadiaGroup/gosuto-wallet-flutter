import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({Key? key}) : super(key: key);

  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double widthTab = 70;
    double heightTab = 70;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          // indicatorColor: Theme.of(context).colorScheme,
          // labelColor: Colors.teal,
          // unselectedLabelColor: Colors.black54,
          // indicator:
          // BoxDecoration(
          //   border: Border.all(
          //     color: Theme.of(context).colorScheme.primary,
          //     width: 15,
          //   ),
          //   // borderRadius: BorderRadius.circular(12), // Creates border
          //   color: AppDarkColors.tabBarIndicatorColor,
          // ),
          padding: const EdgeInsets.all(20),
          isScrollable: true,
          tabs: <Widget>[
            SizedBox(
              width: widthTab,
              height: heightTab,
              child: Tab(
                // text: 'history'.tr,
                // icon: const Icon(Icons.flight),
                icon: SvgPicture.asset('assets/svgs/dark/ic-send.svg'),
              ),
            ),
            SizedBox(
              width: widthTab,
              height: heightTab,
              child: Tab(
                  text: 'send'.tr,
                  // icon: const Icon(Icons.flight),
                  icon: SvgPicture.asset('assets/svgs/dark/ic-send.svg')),
            ),
            SizedBox(
              width: widthTab,
              height: heightTab,
              child: Tab(
                  // text: 'stake'.tr,
                  // icon: const Icon(Icons.flight),
                  icon: SvgPicture.asset('assets/svgs/ic-stake.svg')),
            ),
            SizedBox(
              width: widthTab,
              height: heightTab,
              child: Tab(
                  // iconMargin: const EdgeInsets.only(bottom: 5),
                  // text: 'wallet\nsettings'.tr,
                  // icon: const Icon(Icons.flight),
                  icon: SvgPicture.asset('assets/svgs/ic-send.svg')),
            ),
            SizedBox(
              width: widthTab,
              height: heightTab,
              child: Tab(
                  // text: 'swap'.tr,
                  // icon: const Icon(Icons.flight),
                  icon: SvgPicture.asset('assets/svgs/ic-send.svg')),
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 22),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ChartCard();
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.orangeAccent,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.greenAccent,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.indigoAccent,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
