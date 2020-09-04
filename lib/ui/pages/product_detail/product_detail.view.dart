import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/widgets/product_box_small.dart';

import 'product_detail.model.dart';

// REVIEW bu şeklde parametre tip tanımı güzel mi?
class ProductDetailViewParams {
  final String productId;
  final String tempPhotoAsset;
  ProductDetailViewParams(this.productId, this.tempPhotoAsset);
}

class ProductDetailView extends StatefulWidget {
  final String productId;
  final String tempPhotoAsset;
  final ProductDetailModel productDetailModel;
  ProductDetailView({Key key, this.productId, this.tempPhotoAsset})
      : productDetailModel = ProductDetailModel(productId: productId, tempPhotoAsset: tempPhotoAsset),
        super(key: key) {}

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ThemeService ts = locator<ThemeService>();
  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build called ProductDetailView");
    return ChangeNotifierProvider(
      create: (context) => widget.productDetailModel,
      child: Consumer<ProductDetailModel>(
        builder: (context, model, child) {
          List<Widget> specs = [];
          if (model.prd.specifications != null) {
            for (var i = 0; i < model.prd.specifications.length; i++) {
              specs.add(Text("- " + model.prd.specifications[i]));
            }
          }
          return Scaffold(
            backgroundColor: ts.clr10,
            body: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 54),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: ts.white, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                          child: Column(children: [
                            ProductImagesSlider(product: model.prd),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model.prd.name,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: ts.textColor1),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 16),
                        Container(
                          // TODO bu container'ı Panel diye bir widget yapalım
                          decoration: BoxDecoration(color: ts.white, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Product Details", style: ts.textStyleHeader1),
                              Divider(color: Colors.black),
                              ...specs
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(color: ts.white, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Similar Results", style: ts.textStyleHeader1),
                              Divider(color: Colors.black),
                              ProductRoller(
                                products: model.similarProducts,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                // FOOTER
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 54,
                      decoration: BoxDecoration(color: ts.clr2),
                      child: Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              model.prd.price.toString() + " \$",
                              style: TextStyle(color: ts.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Sepete Ekle"),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
                // HEADER BAR
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey, Colors.transparent],
                        ),
                      ),
                      child: Row(children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {
                            model.goBack();
                          },
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.share),
                          color: Colors.white,
                          onPressed: () {
                            model.share();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          color: Colors.white,
                          onPressed: () {
                            model.addFavourite();
                          },
                        ),
                      ]),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductRoller extends StatelessWidget {
  final ThemeService ts = locator<ThemeService>();
  final List<Product> products;

  ProductRoller({this.products}) : super();

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (products != null) {
      for (var i = 0; i < products.length; i++) {
        items.add(Padding(
            padding: const EdgeInsets.all(4.0),
            child: ProductBoxSmall(
              product: products[i],
            )));
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [...items],
      ),
    );
  }
}

class ProductImagesSlider extends StatefulWidget {
  final Product product;

  ProductImagesSlider({Key key, this.product}) : super(key: key);

  @override
  _ProductImagesSliderState createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  ThemeService ts = locator<ThemeService>();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    print("build called _ProductDetailState");
    return Container(
      // color: ts.clr4,
      child: Column(
        children: <Widget>[
          Container(
            // PRODUCT IMAGES SLIDER
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
          ),
        ],
      ),
    );
  }
}
