import 'package:shoppingappsampleflutter/ui/pages/base.model.dart';

class CartModel extends BaseModel {
  List<String> items;

  CartModel() {
    items = List<String>.generate(40, (i) => (i * 2 + 1).toString());
  }
}
