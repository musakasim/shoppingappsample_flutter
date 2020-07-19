import 'package:flutter/material.dart';

class ThemeService {
  Color white = Colors.white;

  final Color clr1 = Color(0xFF386641);
  final Color clr2 = Color(0xFF6a994e);
  final Color clr3 = Color(0xFFa7c957);
  final Color clr4 = Color(0xFFf2e8cf);
  final Color clr5 = Color(0xFFbc4749);
  final Color clr6 = Colors.deepPurple;
  static MaterialColor themeColorSet = MaterialColor(
    0xFFa7c957,
    {
      50: Color(0xFF386641),
      100: Color(0xFF6a994e),
      200: Color(0xFFa7c957),
      300: Color(0xFFf2e8cf),
      400: Color(0xFFbc4749),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    },
  );

  ThemeData theme = ThemeData(
    primarySwatch: themeColorSet,
    visualDensity: VisualDensity
        .adaptivePlatformDensity, // For desktop platforms, the controls will be smaller and closer together (more dense) than on mobile platforms.
  );
}
