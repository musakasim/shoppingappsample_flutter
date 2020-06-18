import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/routing/navigation_sevice.dart';
import 'package:shoppingappsampleflutter/core/services/routing/routes.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/pages/product_detail/product_detail.view.dart';
import 'package:shoppingappsampleflutter/ui/widgets/favourite_button.dart';

class ProductBox extends StatelessWidget {
  Product product;
  ThemeService ts = locator<ThemeService>();
  NavigationService navigationService = locator<NavigationService>();

  ProductBox({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
            color: ts.clr4,
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 300,
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: 5,
                      left: 5,
                      right: 5,
                      height: 170,
                      child: Container(
                        child: Hero(
                          tag: product.id + 0.toString(),
                          child: Image.asset(
                            product.photoAssets[0],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      right: 3,
                      child: FavouriteButton(),
                    ),

                    // ...product.photoAssets.map((img) => Image.asset(img)).toList()
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _navigateToProductDetail,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: Text(
                              product.name,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Text("${product.price}  ₺"),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.grey),
                        ],
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () => {},
                        color: ts.clr6,
                        height: 20,
                        child: Text(
                          "Sepete Ekle",
                          style: TextStyle(color: ts.clr4),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
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
