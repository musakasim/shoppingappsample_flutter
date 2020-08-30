import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shoppingappsampleflutter/ui/helpers/ticker.dart';
import 'package:shoppingappsampleflutter/ui/widgets/NavigatorX.dart';

import '../base.model.dart';

class HomeModel extends BaseModel {
  final NavigationHistory navigationHistory = NavigationHistory(currentRoute: RouteEntryX("0"));

  final ScrollController scrollController = ScrollController();

  Map<String, ScrollController> scrollControllers = {
    "0": ScrollController(debugLabel: "0"),
    "1": ScrollController(debugLabel: "1"),
    "2": ScrollController(debugLabel: "2"),
    "3": ScrollController(debugLabel: "3"),
    "4": ScrollController(debugLabel: "4"),
    "5": ScrollController(debugLabel: "5"),
  };
  AnimationController pageChangHideTimerAnimationController;
  AnimationController pageChangeAnimationController;
  Tween<Offset> pageChangeSlideTween;
  Tween<double> pageChangeHideTimerTween; //
  TweenSequence<double> pageChangeOpacityTween;

  Animation<Offset> pageChangeSlideAnimation;
  Animation<double> pageChangeHideTimerAnimation;
  Animation<double> pageChangeOpacityAnimation;

  bool _isSearchAppBarVisible = true;
  bool get isSearchAppBarVisible => _isSearchAppBarVisible;
  set isSearchAppBarVisible(bool isSearchAppBarVisible) {
    _isSearchAppBarVisible = isSearchAppBarVisible;
    notifyListeners();
  }

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
    print("HomeModel ctor");
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
          tween: Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeOutCirc)), // Curves.fastOutSlowIn
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
        notifyListeners(); // debug yaparken scroll position'ı görmek için uncomment yapılsın
        if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          if (_isBottomNavBarVisible) {
            isBottomNavBarVisible = false;
          }
          if (_isSearchAppBarVisible && activePageIndex == 0) {
            isSearchAppBarVisible = false;
          }
        }

        if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (!_isBottomNavBarVisible) {
            isBottomNavBarVisible = true;
          }
          if (!_isSearchAppBarVisible && activePageIndex == 0) {
            isSearchAppBarVisible = true;
          }
        }
      },
    );

    // for (var i = 0; i < 6; i++) {
    //   scrollControllers[i.toString()].addListener(
    //     () {
    //       notifyListeners(); // debug yaparken scroll position'ı görmek için uncomment yapılsın
    //       if (scrollControllers[i.toString()].position.userScrollDirection == ScrollDirection.reverse) {
    //         if (_isBottomNavBarVisible) {
    //           isBottomNavBarVisible = false;
    //         }
    //       }

    //       if (scrollControllers[i.toString()].position.userScrollDirection == ScrollDirection.forward) {
    //         if (!_isBottomNavBarVisible) {
    //           isBottomNavBarVisible = true;
    //         }
    //       }
    //     },
    //   );
    // }

    // show first page
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
