import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/helpers/ticker.dart';
import 'package:shoppingappsampleflutter/ui/widgets/NavigatorX.dart';

import '../base.model.dart';

class HomeModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final NavigationHistory navigationHistory = locator<NavigationService>().homePageNavigationHistory;

  final ScrollController scrollController = ScrollController();

  AnimationController pageChangHideTimerAnimationController;
  AnimationController pageChangeAnimationController;
  Tween<Offset> pageChangeSlideTween;
  Tween<double> pageChangeHideTimerTween; //
  TweenSequence<double> pageChangeOpacityTween;

  Animation<Offset> pageChangeSlideAnimation;
  Animation<double> pageChangeHideTimerAnimation;
  Animation<double> pageChangeOpacityAnimation;

  bool _isBottomNavBarVisible = true;
  bool get isBottomNavBarVisible => _isBottomNavBarVisible;
  void set isBottomNavBarVisible(bool val) {
    _isBottomNavBarVisible = val;
    notifyListeners();
  }

  int _activePageIndexTemp = -1;
  int _activePageIndex = 0;
  int get activePageIndex => _activePageIndex;
  void set activePageIndex(int val) {
    _activePageIndex = val;
    notifyListeners();
  }

  HomeModel() {
    pageChangeAnimationController =
        AnimationController(duration: const Duration(milliseconds: 200), vsync: SingleTickerProvider());
    // ilk açılışsa slide olmaması için başlangıç bitiş aynı yap:
    pageChangeSlideTween = Tween<Offset>(begin: Offset.zero, end: Offset.zero);
    pageChangeSlideAnimation = pageChangeSlideTween
        .chain(CurveTween(curve: Interval(0.10, 1.0, curve: Curves.easeOut)))
        .animate(pageChangeAnimationController)
          ..addListener(() {
            notifyListeners();
          });

    pageChangeOpacityTween = TweenSequence(
      [
        // TweenSequenceItem<double>(
        //   tween: Tween<double>(begin: 1, end: 0).chain(CurveTween(curve: Curves.easeInOutCirc)),
        //   weight: 1.0,
        // ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeOutCirc)),
          weight: 100.0,
        ),
      ],
    );
    pageChangeOpacityAnimation =
        pageChangeOpacityTween.chain(CurveTween(curve: Interval(0.0, 1.0))).animate(pageChangeAnimationController)
          ..addListener(() {
            notifyListeners();
          });

    pageChangHideTimerAnimationController =
        AnimationController(duration: const Duration(milliseconds: 2), vsync: SingleTickerProvider());
    pageChangeHideTimerTween = Tween(begin: 1.0, end: 0.0);
    pageChangeHideTimerAnimation = pageChangeHideTimerTween
        .chain(CurveTween(curve: Interval(0.0, 0.05, curve: Curves.easeOutCirc)))
        .animate(pageChangHideTimerAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              activePageIndex = _activePageIndexTemp;
            }
          });
    scrollController.addListener(
      () {
        if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          if (_isBottomNavBarVisible) {
            isBottomNavBarVisible = false;
          }
        }

        if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (!_isBottomNavBarVisible) {
            isBottomNavBarVisible = true;
          }
        }
      },
    );

    pageChangeAnimationController.forward();
  }

  changeActivePage(int index, bool pushHistory) {
    if (activePageIndex == index) {
      return;
    } else if (this.activePageIndex > index) {
      pageChangeSlideTween.begin = Offset(-1.0, 0.0);
      pageChangeSlideTween.end = Offset.zero;
    } else {
      pageChangeSlideTween.begin = Offset(1.0, 0.0);
      pageChangeSlideTween.end = Offset.zero;
    }
    pageChangeAnimationController.reset();
    pageChangeAnimationController.forward();
    pageChangHideTimerAnimationController.reset();
    pageChangHideTimerAnimationController.forward();
    _activePageIndexTemp = index;
    if (pushHistory) {
      navigationHistory.push(index.toString());
    }
  }

  goBack() {
    navigationHistory.maybePop();
  }

  onWillPop() async {
    print("onWillPop:" +
        navigationHistory.canPop().toString() +
        " current Route:" +
        navigationHistory.currentRoute.routeName);
    if (navigationHistory.canPop()) {
      print("HERE");
      RouteEntryX currentRoute = navigationHistory.maybePop();
      changeActivePage(int.parse(currentRoute.routeName), false);
      return false;
    }
    print("HERE2");
    return true;
  }
}
