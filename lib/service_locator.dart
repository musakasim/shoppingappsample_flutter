import 'package:get_it/get_it.dart';
import 'package:shoppingappsampleflutter/core/services/db.service.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/core/services/api/products.service.dart';
import 'package:shoppingappsampleflutter/core/services/authentication.service.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ThemeService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ProductsService());
  locator.registerLazySingleton(() => DbService());
}