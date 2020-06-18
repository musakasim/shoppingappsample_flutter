import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation_sevice.dart';
import 'package:shoppingappsampleflutter/core/services/routing/routes.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeService ts = locator<ThemeService>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alışveriş Yap!',
      theme: ThemeData(
        primarySwatch: ts.themeColorSet,
        visualDensity: VisualDensity
            .adaptivePlatformDensity, // For desktop platforms, the controls will be smaller and closer together (more dense) than on mobile platforms.
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Routes().generateRoutes,
      initialRoute: Routes.Splash,
    );
  }
}
