
import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/ui/styles/screen_helper.dart';

class UIBoxDecorations {
static BoxDecoration boxStyle = BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Colors.blue,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(
              3.0,
              3.0,
            )),
      ],
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ScreenHelper.dynamicWidth(150)),
          bottomRight: Radius.circular(ScreenHelper.dynamicWidth(150))),
      color: Colors.blue);
}
// decoration: UIBoxDecoration.boxStyle, //Bu şekilde kullanabilirsiniz.