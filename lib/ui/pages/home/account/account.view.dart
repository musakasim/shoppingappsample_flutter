import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'account.model.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountModel(),
      child: Consumer<AccountModel>(
        builder: (context, model, child) => Container(
          child: Column(
            children: [
              Text("1"),
              Text("2"),
              Text("3"),
              Text("4"),
              Text("8"),
              Text("8"),
              Text("8"),
              Text("8"),
              Text("8"),
              Text("8"),
              Text("8"),
            ],
          ),
        ),
      ),
    );
  }
}
