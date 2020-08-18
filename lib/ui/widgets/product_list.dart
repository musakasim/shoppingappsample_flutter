import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/core/services/api/products.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/widgets/product_box.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ThemeService ts = locator<ThemeService>();

  ProductsService prdService = locator<ProductsService>();

  Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = prdService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: products,
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          print('snapshot.data?.length: ' + snapshot.data?.length.toString());
          if (snapshot.connectionState == ConnectionState.done) {
            var rows = List<Widget>();
            for (var i = 0; i + 1 < snapshot.data.length; i += 2) {
              rows.add(Row(
                children: <Widget>[
                  Expanded(child: ProductBox(product: snapshot.data[i])),
                  Expanded(child: ProductBox(product: snapshot.data[i + 1])),
                ],
              ));

              rows.add(SizedBox(
                height: 15,
              ));
            }

            return Column(
              children: rows,
            );
          } else
            return Text("Yükleniyor");
        },
      ),
    );
  }
}
