// from: https://stackoverflow.com/a/58811885/1538014
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// eg: 
// use as top level widget:
//    Material(
//        child: DrawerStack(
//          body: body(),
//          drawer: _drawer(),
//        ),
//      ),
//    )
// open with button:
//    RaisedButton(
//      child: Text('Open drawer'),
//      onPressed: () {
//        context.findAncestorWidgetOfExactType<DrawerStack>().openDrawer();
//        // DrawerStack.of(context).openDrawer();
//      },
//    )
class DrawerStack extends StatelessWidget {
  final GlobalKey<DrawerControllerState> _drawerKey = GlobalKey<DrawerControllerState>();
  final drawerScrimColor = Color.fromARGB(90, 100, 100, 128);

  final Widget body;
  final Widget drawer;

  DrawerStack({Key key, this.body, this.drawer}) : super(key: key);

  void openDrawer() {
    _drawerKey.currentState?.open();
  }

  void closeDrawer() {
    _drawerKey.currentState?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // body
        body,

        DrawerController(
          key: _drawerKey,
          alignment: DrawerAlignment.start,
          child: drawer,
          drawerCallback: (_) {},
          dragStartBehavior: DragStartBehavior.down,
          scrimColor: drawerScrimColor,
          edgeDragWidth: null,
        ),
      ],
    );
  }
}
