import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/api/products.service.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

import '../base.model.dart';

class ProductDetailModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProductsService prdService = locator<ProductsService>();

  final String productId;
  final String tempPhotoAsset;

  Product _prd;
  Product get prd => _prd;
  set prd(Product prd) {
    this._prd = prd;
    notifyListeners();
  }

  List<Product> _similarProducts;
  List<Product> get similarProducts => _similarProducts;
  set similarProducts(List<Product> similarProducts) {
    this._similarProducts = similarProducts;
    notifyListeners();
  }

  ProductDetailModel({this.productId, this.tempPhotoAsset}) {
    prd = Product(
      id: productId,
      photoAssets: tempPhotoAsset != null ? [tempPhotoAsset] : [],
      name: "",
      price: 0,
    );
    fetchProductDetail();
    getSimilarItems();
  }

  fetchProductDetail() async {
    prd = await prdService.getProduct(productId);
  }

  void goBack() {
    _navigationService.goBack();
  }

  void share() {
    print("TODO paylaş ekranı açılacak");
  }

  void addFavourite() {
    print("TODO favori yapısı hazırlanacak");
  }

  getSimilarItems() async {
    this.similarProducts = await prdService.getProducts();
  }
}
