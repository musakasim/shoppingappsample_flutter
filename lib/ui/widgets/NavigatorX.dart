import 'package:flutter/cupertino.dart';

class NavigatorX extends StatefulWidget {
  final Widget child;

  NavigatorX({Key key, this.child}) : super(key: key);

  @override
  _NavigatorXState createState() => _NavigatorXState();
}

class _NavigatorXState extends State<NavigatorX> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class NavigationHistory {
  // route history excluding current route
  List<RouteEntryX> history = List<RouteEntryX>();
  RouteEntryX currentRoute;

  NavigationHistory({@required this.currentRoute});

  push(String routeName) {
    history.add(currentRoute);
    currentRoute = RouteEntryX(routeName);
  }

  RouteEntryX maybePop() {
    if (canPop()) {
      print("maybePop:");
      this.currentRoute = history.removeLast();
      return currentRoute;
    } else {
      this.currentRoute = null;
    }
    return this.currentRoute;
  }

  canPop() {
    return history.length > 0;
  }
}

class RouteEntryX {
  String routeName;

  RouteEntryX(this.routeName);
}
