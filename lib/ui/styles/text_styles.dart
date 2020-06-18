import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

class UITextStyles {
  static ThemeService themeService = locator<ThemeService>();

  static TextStyle headerStyle1 = TextStyle(
    fontFamily: 'Montserrat',
    color: themeService.white,
    fontSize: 45,
    fontWeight: FontWeight.w500,
  );
}
// Text("login", style: UITextStyles.loginStyle))); //Bu şekilde kullanabilirsiniz.

