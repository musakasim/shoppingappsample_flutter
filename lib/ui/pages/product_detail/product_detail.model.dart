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
  get prd => _prd;
  set prd(Product prd) {
    this._prd = prd;
    notifyListeners();
  }

  ProductDetailModel({this.productId, this.tempPhotoAsset}) {
    prd = Product(
      id: productId,
      photoAssets: tempPhotoAsset != null ? [tempPhotoAsset] : [],
      name: "",
      price: 0,
    );
    FetchProductDetail();
  }

  FetchProductDetail() async {
    prd = await prdService.getProduct(productId);
  }
}
