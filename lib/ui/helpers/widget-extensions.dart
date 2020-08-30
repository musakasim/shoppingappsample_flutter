// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingappsampleflutter/ui/widgets/drawer_stack.dart';
import 'package:shoppingappsampleflutter/ui/widgets/menu-drawer.dart';

extension WidgetExtensions on Widget {
  Widget centered() {
    return Center(
      child: this,
    );
  }

  Widget withMenuDrawer() {
    return DrawerStack(
      drawer: MenuDrawer(),
      body: this,
    );
  }

  // ! kullanmadan önce https://github.com/flutter/flutter/issues/47088  takip et
  // ! bunu ekleyince alt seviedeki willpopscope'lar hiç çalışmıyor
  Widget withSafeExit() {
    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: this,
    );
  }

  static DateTime currentBackPressTime;
  // TODO back press to exit çalıştırılacak:
  _onBackPressed() {
    DateTime now = DateTime.now();
    print("HERE _onBackPressed");
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      print("HERE _onBackPressed2");
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Çıkmak için tekrar tıklayın");
      return Future.value(false);
    }
    print("HERE _onBackPressed3");
    return Future.value(true);
  }
}
