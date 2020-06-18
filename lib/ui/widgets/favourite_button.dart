import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

class FavouriteButton extends StatelessWidget {
  ThemeService ts = locator<ThemeService>();
  FavouriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          child: Center(
            child: Container(
              child: Text(
                "beğenildi",
                style: TextStyle(
                  color: ts.clr2,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.favorite,
        color: ts.clr5,
      ),
    );
  }
}
