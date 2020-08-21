import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

import '../base.model.dart';

class HomeModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final ScrollController controller = ScrollController();

  bool _isBottomNavBarVisible = true;
  bool get isBottomNavBarVisible => _isBottomNavBarVisible;
  void set isBottomNavBarVisible(bool val) {
    _isBottomNavBarVisible = val;
    notifyListeners();
  }

  int _activePageIndex = 0;
  int get activePageIndex => _activePageIndex;
  void set activePageIndex(int val) {
    _activePageIndex = val;
    notifyListeners();
  }

  HomeModel() {
    controller.addListener(
      () {
        if (controller.position.userScrollDirection == ScrollDirection.reverse) {
          if (_isBottomNavBarVisible) {
            isBottomNavBarVisible = false;
          }
        }

        if (controller.position.userScrollDirection == ScrollDirection.forward) {
          if (!_isBottomNavBarVisible) {
            isBottomNavBarVisible = true;
          }
        }
      },
    );
  }

  changeActivePage(int index) {
    activePageIndex = index;
  }
}
