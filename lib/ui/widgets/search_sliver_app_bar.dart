import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/ui/widgets/drawer_stack.dart';

import '../../service_locator.dart';

class SearchSliverAppBar extends StatelessWidget {
  final ThemeService ts = locator<ThemeService>();

  final VoidCallback onPressedMenu;
  // final Function(bool) onPressedMenu;

  SearchSliverAppBar({
    Key key,
    this.onPressedMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 50.0,
      // stretch: true,
      pinned: false,
      floating: true,
      snap: true,
      // primary: true,
      // onStretchTrigger: () {
      //   print("sdfsd");
      //   // Function callback for stretch
      //   return;
      // },
      leading: IconButton(
        // padding: EdgeInsets.all(0),
        // iconSize: 30,
        icon: Icon(Icons.menu),
        onPressed: () => _onPressedMenu(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.fromLTRB(50, 0, 50, 5),
        title: TextField(
          onChanged: (value) {
            print("aaaa $value");
          },
          style: TextStyle(color: ts.white, fontSize: 18),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: ts.clr4,
              ),
              hintText: "Ara",
              hintStyle: TextStyle(color: ts.clr1)),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => {},
          color: ts.clr5,
        )
      ],
    );
  }

  void _onPressedMenu(BuildContext context) {
    print("menu button pressed");
    context.findAncestorWidgetOfExactType<DrawerStack>().openDrawer();
    if (this.onPressedMenu != null) {
      this.onPressedMenu();
    }
  }
}
