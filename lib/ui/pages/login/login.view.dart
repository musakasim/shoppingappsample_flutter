import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingappsampleflutter/ui/widgets/button-1.dart';

import 'login.model.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginPageModel(),
      child: Consumer<LoginPageModel>(
        builder: (context, model, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button1(
                text: 'Login',
                onTap: () => model.login(),
                model: model,
                errorTextColor: Colors.red[800],
                boxShadowColor: Colors.red[200],
                boxDecorationColor: Colors.red,
                circularProgressIndicatorColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
