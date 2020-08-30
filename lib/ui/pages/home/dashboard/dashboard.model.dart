import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/api/products.service.dart';
import 'package:shoppingappsampleflutter/ui/pages/base.model.dart';

import '../../../../service_locator.dart';

class DashboardModel extends BaseModel {
  List<Product> _products = List<Product>();
  List<Product> get products => _products;
  set products(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  ProductsService productsService = locator<ProductsService>();

  DashboardModel() {
    loadProducts();
  }

  void loadProducts() async {
    products = await productsService.getProducts();
  }
}
