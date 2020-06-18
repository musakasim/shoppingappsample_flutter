import 'package:flutter/cupertino.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation_sevice.dart';
import 'package:shoppingappsampleflutter/core/services/routing/routes.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

import '../base.model.dart';

class SplashModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  PageController _pageController = PageController();
  int _imageIndex = 0;
  bool _isLastPage = false;
  bool _isFirstPage = true;

  PageController get pageController => _pageController;
  int get imageIndex => _imageIndex;
  bool get isLastPage => _isLastPage;
  bool get isFirstPage => _isFirstPage;
  int get imageCount => 2;

  Future next() async {
    if (_imageIndex + 1 < imageCount) {
      this._imageIndex++;
      _pageController.animateToPage(
        imageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      this._isLastPage = _imageIndex == imageCount - 1;
      this._isFirstPage = _imageIndex == 0;
    } else {
      this.skipFinish();
    }
    notifyListeners();
  }

  Future previous() async {
    if (_imageIndex - 1 > -1) {
      this._imageIndex--;
      _pageController.animateToPage(
        imageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      this._isLastPage = _imageIndex == imageCount - 1;
      this._isFirstPage = _imageIndex == 0;
    }
    notifyListeners();
  }

  Future jumpTo(int idx) async {
    print("idx $idx");
    if (idx < imageCount) {
      this._imageIndex = idx;
      _pageController.animateToPage(
        imageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      this._isLastPage = _imageIndex == imageCount - 1;
      this._isFirstPage = _imageIndex == 0;
    } else {
      this.skipFinish();
    }
    notifyListeners();
  }

  void skipFinish() {
    _navigationService.navigateToWithClearHistory(Routes.Home);
  }
}
