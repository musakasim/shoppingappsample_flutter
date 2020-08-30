import 'package:get_it/get_it.dart';
import 'package:shoppingappsampleflutter/core/services/db.service.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/core/services/api/products.service.dart';
import 'package:shoppingappsampleflutter/core/services/authentication.service.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';
import 'package:shoppingappsampleflutter/ui/pages/home/cart/cart.model.dart';
import 'package:shoppingappsampleflutter/ui/pages/home/dashboard/dashboard.model.dart';
import 'package:shoppingappsampleflutter/ui/pages/home/home.model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ThemeService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ProductsService());
  locator.registerLazySingleton(() => DbService());

  // View Models:
  locator.registerLazySingleton(() => HomeModel());
  locator.registerLazySingleton(() => DashboardModel());
  locator.registerLazySingleton(() => CartModel());
}
