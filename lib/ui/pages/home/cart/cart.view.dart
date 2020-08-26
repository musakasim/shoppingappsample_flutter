import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'cart.model.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: Consumer<CartModel>(
        builder: (context, model, child) => Column(children: [
          ListView.builder(
            itemCount: model.items.length,
            itemBuilder: (context, index) {
              return Container(child: Text(model.items[index]), height: 100,);
            },
            // shrinkWrap: true aşağıdaki  sebepten dolayı:
            // Vertical viewport was given unbounded height.
            // Viewports expand in the scrolling direction to fill their container. In this case, a vertical
            // viewport was given an unlimited amount of vertical space in which to expand. This situation
            // typically happens when a scrollable widget is nested inside another scrollable widget.
            // If this widget is always nested in a scrollable widget there is no need to use a viewport because
            // there will always be enough vertical space for the children. In this case, consider using a Column
            // instead. Otherwise, consider using the "shrinkWrap" property (or a ShrinkWrappingViewport) to size
            // the height of the viewport to the sum of the heights of its children.
            shrinkWrap: true,
          ),
        ]),
      ),
    );
  }
}
