import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  DateTime currentBackPressTime;

  HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, model, child) => Scaffold(
          body: FadeTransition(
              opacity: model.pageChangeOpacityAnimation,
              child: SlideTransition(
                position: model.pageChangeSlideAnimation,
                child: Container(
                  child: CustomScrollView(
                    controller: model.scrollController,
                    slivers: [
                      SearchSliverAppBar(),
                      SliverList(delegate: SliverChildListDelegate([getCurrentPageView(model.activePageIndex)])),
                    ],
                  ),
                ),
              )),
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
                    onTap: (index) => {model.changeActivePage(index)},
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Consumer<HomeModel>(
            builder: (context, model, child) => Text("debug:" + model.pageChangeSlideAnimation.value.toString()),
          ),
          // persistentFooterButtons: <Widget>[
          //   Text("Test1"),
          //   Text("Test2"),
          // ],
        ),
      ),
    );
  }

  Widget getCurrentPageView(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return Dashboard();
      case 1:
        return Cart();
      case 2:
        return Account();
      case 3:
        return Account();
      case 4:
        return Account();
      default:
        return Dashboard();
    }
  }

  // TODO back press to exit çalıştırılacak:
  _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Çıkmak için tekrar tıklayın");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
