import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';
import 'package:shoppingappsampleflutter/core/services/routing/routes.dart';
import 'package:shoppingappsampleflutter/core/models/app_config.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  // WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeService ts = locator<ThemeService>();
  NavigationService navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();

    checkIfIntroSeenByUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alışveriş Yap!',
      theme: ts.theme,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Routes().generateRoutes,
      initialRoute: Routes.Loading,
    );
  }

  Future<void> checkIfIntroSeenByUser() async {
    var initShownBefore = await AppConfig().getById(1);
    print("initShownBefore $initShownBefore");
    // setState(() {});
    final hasIntroSeenByUser = initShownBefore?.value == "true";
    print("initShownBefore $initShownBefore");
    print("hasIntroSeenByUser $hasIntroSeenByUser");

    if (!hasIntroSeenByUser) {
      navigationService.navigateToWithClearHistory(Routes.Splash);
    } else {
      navigationService.navigateToWithClearHistory(Routes.Home);
    }
  }
}
