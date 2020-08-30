import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/pages/home/account/account.view.dart';
import 'package:shoppingappsampleflutter/ui/widgets/search_sliver_app_bar.dart';

import 'cart/cart.view.dart';
import 'dashboard/dashboard.view.dart';
import 'home.model.dart';

class HomeView extends StatelessWidget {
  final ThemeService ts = locator<ThemeService>();
  final HomeModel homeModel = locator<HomeModel>();
  // DateTime currentBackPressTime;

  HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      // create: (context) => HomeModel(),
      value: homeModel,
      child: Consumer<HomeModel>(
        builder: (context, model, child) => WillPopScope(
          onWillPop: () async => await model.onWillPop(),
          child: Scaffold(
            body: FadeTransition(
              opacity: model.pageChangeOpacityAnimation,
              child: SlideTransition(
                position: model.pageChangeSlideAnimation,
                child: Container(
                  child: CustomScrollView(
                    // key: PageStorageKey(model.activePageIndex.toString()),
                    controller: model.scrollControllers[model.activePageIndex.toString()], //model.scrollController, //
                    slivers: getCurrentPageView(model.activePageIndex),
                  ),
                ),
              ),
            ),
            // body: FadeTransition(
            //     opacity: model.pageChangeOpacityAnimation,
            //     child: SlideTransition(
            //       position: model.pageChangeSlideAnimation,
            //       child: Container(
            //         child: CustomScrollView(
            //           controller: model.scrollController,
            //           slivers: [
            //             SearchSliverAppBar(),
            //             SliverList(delegate: SliverChildListDelegate([getCurrentPageView(model.activePageIndex)])),
            //           ],
            //         ),
            //       ),
            //     )),
            // body: getCurrentPageView(model.activePageIndex),
            bottomNavigationBar: Consumer<HomeModel>(
              builder: (context, model, child) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: model.isBottomNavBarVisible ? 56.0 : 0.0,
                child: Wrap(
                  children: [
                    BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: ts.clr2,
                      selectedItemColor: ts.clr4,
                      unselectedItemColor: Colors.white,
                      currentIndex: model.activePageIndex,
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
                        BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Account'),
                        BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Account'),
                        BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Account'),
                        BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Account'),
                      ],
                      onTap: (index) => {model.changeActivePage(index, true)},
                    ),
                  ],
                ),
              ),
            ),
            bottomSheet: Consumer<HomeModel>(
              // builder: (context, model, child) => Text("debug:" + model.pageChangeSlideAnimation.value.toString()),
              // builder: (context, model, child) => Text("debug:" + model.scrollController.toString()),
              builder: (context, model, child) =>
                  Text("debug:" + model.scrollControllers[model.activePageIndex.toString()].toString()),
            ),
            // persistentFooterButtons: <Widget>[
            //   Text("Test1"),
            //   Text("Test2"),
            // ],
          ),
        ),
      ),
    );
  }

  List<Widget> getCurrentPageView(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return [
          SearchSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate([Dashboard()])),
        ];
      case 1:
        return [
          SliverList(delegate: SliverChildListDelegate([Cart()]))
        ];
      case 2:
        return [
          SliverList(delegate: SliverChildListDelegate([Account()]))
        ];
      case 3:
        return [
          SliverList(delegate: SliverChildListDelegate([Account()]))
        ];
      case 4:
        return [
          SliverList(delegate: SliverChildListDelegate([Dashboard()]))
        ];
      default:
        return [
          SliverList(delegate: SliverChildListDelegate([Dashboard()]))
        ];
    }
  }

  Widget getCurrentPageViewByName(String name) {
    switch (name) {
      case "Home":
        return Dashboard();
      case "Cart":
        return Cart();
      case "Account":
        return Account();
      default:
        return Dashboard();
    }
  }

  // // TODO back press to exit çalıştırılacak:
  // _onBackPressed() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     Fluttertoast.showToast(msg: "Çıkmak için tekrar tıklayın");
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }
}

// SAMPLE ANIMATION FLOW:

//   Widget _buildPageFlow(
//     BuildContext context,
//     int tabIndex,
//     _MaterialBottomNavigationTab item,
//   ) {
//     final isCurrentlySelected = tabIndex == widget.selectedIndex;

//     // We should build the tab content only if it was already built or
//     // if it is currently selected.
//     _shouldBuildTab[tabIndex] =
//         isCurrentlySelected || _shouldBuildTab[tabIndex];

//     final Widget view = FadeTransition(
//       opacity: _animationControllers[tabIndex].drive(
//         CurveTween(curve: Curves.fastOutSlowIn),
//       ),
//       child: KeyedSubtree(
//         key: item.subtreeKey,
//         child: _shouldBuildTab[tabIndex]
//             ? Navigator(
//                 // The key enables us to access the Navigator's state inside the
//                 // onWillPop callback and for emptying its stack when a tab is
//                 // re-selected. That is why a GlobalKey is needed instead of
//                 // a simpler ValueKey.
//                 key: item.navigatorKey,
//                 // Since this isn't the purpose of this sample, we're not using
//                 // named routes. Because of that, the onGenerateRoute callback
//                 // will be called only for the initial route.
//                 onGenerateRoute: (settings) => MaterialPageRoute(
//                   settings: settings,
//                   builder: item.initialPageBuilder,
//                 ),
//               )
//             : Container(),
//       ),
//     );

//     if (tabIndex == widget.selectedIndex) {
//       _animationControllers[tabIndex].forward();
//       return view;
//     } else {
//       _animationControllers[tabIndex].reverse();
//       if (_animationControllers[tabIndex].isAnimating) {
//         return IgnorePointer(child: view);
//       }
//       return Offstage(child: view);
//     }
//   }
// }
