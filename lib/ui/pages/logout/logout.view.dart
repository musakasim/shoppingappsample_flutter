import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shoppingappsampleflutter/ui/widgets/button-1.dart';

import 'logout.model.dart';

class LogoutView extends StatelessWidget {
  final String userName;
  DateTime currentBackPressTime;
  LogoutView({Key key, this.userName = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogoutModel(),
      child: Consumer<LogoutModel>(
        builder: (context, model, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Align(
              alignment: Alignment.center,
              child: Button1(
                text: 'Logout' + userName,
                onTap: () => model.logout(),
                model: model,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
