import 'package:dio/dio.dart';
import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/api/sample_data/sample_products.dart';

class ProductsService {
  Future<List<Product>> getProducts() async {
    try {
      Response response = await Dio().get("http://www.google.com");
      print(response);
    } catch (e) {
      print(e);
    }

    return [
      ...sampleProducts1,
    ];
  }

  Future<Product> getProduct(String productId) async {
    try {
      // Response response = await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      print(e);
    }

    return sampleProducts1.firstWhere((element) => element.id == productId);
  }
}
