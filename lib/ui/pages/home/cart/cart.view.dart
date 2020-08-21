import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'cart.model.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: Consumer<CartModel>(
        builder: (context, model, child) => Container(
          child: SizedBox(
            height: 100,
            child: ListView(
              children: [
                Text("1"),
                Text("2"),
                Text("3"),
                Text("4"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
