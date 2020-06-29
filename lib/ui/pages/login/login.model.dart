import 'package:shoppingappsampleflutter/core/services/authentication.service.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';
import 'package:shoppingappsampleflutter/core/services/routing/routes.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

import '../base.model.dart';

class LoginPageModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future login({bool success = true}) async {
    setState(ViewState.Busy);

    await _authenticationService.login("Ahmet");

    if (!success) {
      setErrorMessage('Error has occured with the login');
    } else {
      _navigationService.navigateTo(Routes.Logout);
      setErrorMessage(null);
    }

    setState(ViewState.Idle);
  }
}
