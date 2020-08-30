import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/ui/pages/home/home.view.dart';
import 'package:shoppingappsampleflutter/ui/pages/loading/loading.view.dart';
import 'package:shoppingappsampleflutter/ui/pages/logout/logout.view.dart';
import 'package:shoppingappsampleflutter/ui/pages/parent-page.dart';
import 'package:shoppingappsampleflutter/ui/pages/product_detail/product_detail.view.dart';
import 'package:shoppingappsampleflutter/ui/pages/splash/splash.view.dart';
import 'package:shoppingappsampleflutter/ui/pages/login/login.view.dart';
import 'package:shoppingappsampleflutter/ui/helpers/widget-extensions.dart';

class Routes {
  static const String Loading = "/loading";
  static const String Splash = "/splash";
  static const String Home = "/";
  static const String Login = "/login";
  static const String Logout = "/logout";
  static const String ProductDetail = "/product_detail";

  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.Loading:
        return MaterialPageRoute(builder: (context) => LoadingView());
      case Routes.Splash:
        return MaterialPageRoute(builder: (context) => SplashView());
      case Routes.Login:
        return MaterialPageRoute(builder: (context) => LoginView());
      case Routes.Logout:
        print("settings $settings");
        String userName = "";
        if (settings.arguments is String) {
          userName = settings.arguments as String;
        }
        return MaterialPageRoute(builder: (context) => LogoutView());
      case Routes.Home:
        // return MaterialPageRoute(builder: (context) => ParentPage(child: HomeView()));
        return MaterialPageRoute(builder: (context) => (HomeView().withMenuDrawer()));// .withSafeExit()
      case Routes.ProductDetail:
        ProductDetailViewParams prdDetArgs;
        if (settings.arguments is ProductDetailViewParams) {
          prdDetArgs = settings.arguments as ProductDetailViewParams;
        }
        return MaterialPageRoute(
          builder: (context) => ProductDetailView(
            productId: prdDetArgs?.productId,
            tempPhotoAsset: prdDetArgs?.tempPhotoAsset,
          ).withMenuDrawer(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
