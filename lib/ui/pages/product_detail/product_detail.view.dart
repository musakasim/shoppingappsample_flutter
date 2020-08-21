import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/widgets/search_sliver_app_bar.dart';

import 'product_detail.model.dart';

// REVIEW bu şeklde parametre tip tanımı güzel mi?
class ProductDetailViewParams {
  final String productId;
  final String tempPhotoAsset;
  ProductDetailViewParams(this.productId, this.tempPhotoAsset);
}

class ProductDetailView extends StatelessWidget {
  final ThemeService ts = locator<ThemeService>();
  final String productId;
  final String tempPhotoAsset;
  final ProductDetailModel productDetailModel;
  ProductDetailView({Key key, this.productId, this.tempPhotoAsset})
      : productDetailModel = ProductDetailModel(productId: productId, tempPhotoAsset: tempPhotoAsset),
        super(key: key) {}

  @override
  Widget build(BuildContext context) {
    print("build called ProductDetailView");
    return ChangeNotifierProvider(
      create: (context) => productDetailModel,
      child: Consumer<ProductDetailModel>(
        builder: (context, model, child) => Scaffold(
          body: CustomScrollView(
            slivers: [
              SearchSliverAppBar(),
              SliverList(delegate: SliverChildListDelegate([ProductDetail(product: model.prd)])),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ThemeService ts = locator<ThemeService>();

  // TODO model'e alınacak Stateless widget yapılacak
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    print("build called _ProductDetailState");
    return Container(
      // color: ts.clr4,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Icon(Icons.share, color: ts.clr3),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                CarouselSlider.builder(
                  itemCount: widget.product.photoAssets.length,
                  itemBuilder: (context, int idx) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Hero(
                        tag: widget.product.id + idx.toString(),
                        child: Image.asset(
                          widget.product.photoAssets[idx],
                          // fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    height: 400,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    enlargeCenterPage: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.product.photoAssets.map((url) {
                    int index = widget.product.photoAssets.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
