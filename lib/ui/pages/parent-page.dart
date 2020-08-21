import 'package:flutter/widgets.dart';
import 'package:shoppingappsampleflutter/ui/widgets/drawer_stack.dart';
import 'package:shoppingappsampleflutter/ui/widgets/menu-drawer.dart';

class ParentPage extends StatelessWidget {
  final Widget child;
  ParentPage({key, this.child}) : super();

  @override
  Widget build(BuildContext context) {
    return DrawerStack(
      body: child,
      drawer: MenuDrawer(),
    );
  }
}
