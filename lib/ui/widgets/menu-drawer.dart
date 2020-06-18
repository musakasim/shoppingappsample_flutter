import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FlatButton(
        child: Text('Hesabım'),
        onPressed: () => navigateAccountPage(context),
        autofocus: true,
        clipBehavior: Clip.hardEdge,
      ),
    );
  }

  navigateAccountPage(context) {
    showDialog(context: context, child: Text('test'));
  }
}
