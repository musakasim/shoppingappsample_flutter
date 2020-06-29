
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';
import 'package:shoppingappsampleflutter/core/services/routing/routes.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

import '../base.model.dart';

class LogoutModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future logout({bool success = true}) async {
    setState(ViewState.Busy);
    await Future.delayed(Duration(seconds: 1));

    if (!success) {
      setErrorMessage('Error has occured during sign out');
    } else {
      // _navigationService.goBack();
      _navigationService.navigateTo(Routes.Login);
    }
  }
}
