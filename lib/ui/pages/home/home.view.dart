import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/widgets/product_list.dart';
import 'package:shoppingappsampleflutter/ui/widgets/search_app_bar.dart';

import 'home.model.dart';

class HomeView extends StatelessWidget {
  ThemeService ts = locator<ThemeService>();
  var currentBackPressTime;
  HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, model, child) => Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SearchAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    ProductList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Çıkmak için tekrar tıklayın");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
