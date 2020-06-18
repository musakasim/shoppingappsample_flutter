import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

class SearchBox extends StatelessWidget {
  ThemeService ts = locator<ThemeService>();

  final ValueChanged<String> onChanged;
  SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: ts.clr2.withOpacity(0.32),
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Image.asset("assets/search.png"),
          hintText: "Ara",
          hintStyle: TextStyle(color: ts.clr2),
        ),
      ),
    );
  }
}
