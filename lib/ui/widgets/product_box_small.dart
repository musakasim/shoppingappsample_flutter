import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation.sevice.dart';
import 'package:shoppingappsampleflutter/core/services/routing/routes.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/pages/product_detail/product_detail.view.dart';

class ProductBoxSmall extends StatelessWidget {
  final Product product;
  final ThemeService ts = locator<ThemeService>();
  final NavigationService navigationService = locator<NavigationService>();

  ProductBoxSmall({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToProductDetail,
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ts.clr3,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: ts.clr4,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              child: Text(product.name),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              height: 120,
              width: 120,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  product.photoAssets[0],
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _navigateToProductDetail() {
    navigationService.navigateTo(Routes.ProductDetail,
        arguments: ProductDetailViewParams(
          product.id,
          product.photoAssets[0],
        ));
  }
}
