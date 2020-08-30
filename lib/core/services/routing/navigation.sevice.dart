import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/services/routing/routes.dart';
import 'package:shoppingappsampleflutter/ui/widgets/NavigatorX.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: "AAAAAAAAAAAA");
  final NavigationHistory homePageNavigationHistory = NavigationHistory(currentRoute: RouteEntryX("0"));

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToWithClearHistory(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName(Routes.Home), arguments: arguments);
  }

  bool hasPrevious() {
    return navigatorKey.currentState.canPop();
  }

  void goBack() {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
    }
  }
}
