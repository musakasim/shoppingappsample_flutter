import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/core/models/product.dart';
import 'package:shoppingappsampleflutter/core/services/theme.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';
import 'package:shoppingappsampleflutter/ui/widgets/product_box.dart';

class ProductList extends StatelessWidget {
  final ThemeService ts = locator<ThemeService>();
  final List<Product> products;

  ProductList({@required this.products});

  @override
  Widget build(BuildContext context) {
    // var rows = List<Widget>();

    // var row = Row(children: []);
    // for (var i = 0; i < products.length; i++) {
    //   if (row.children.length == 2) {
    //     rows.add(row);
    //     rows.add(SizedBox(height: 15));
    //     row = Row(children: []);
    //   }

    //   row.children.add(Expanded(child: ProductBox(product: products[i])));
    // }

    // return Container(
    //   child: Column(
    //     children: rows,
    //   ),
    // );

    return ListView.separated(
      key: PageStorageKey("product-list"),
      physics: ClampingScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 10),
      padding: EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Container(
          child: ProductBox(product: products[index]),
        );
      },
      shrinkWrap: true,
    );
  }
}

// class _ProductListState extends State<ProductList> {
//   ThemeService ts = locator<ThemeService>();

//   ProductsService prdService = locator<ProductsService>();

//   Future<List<Product>> products;

//   @override
//   void initState() {
//     super.initState();
//     print("ProductList.initState");
//     products = prdService.getProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FutureBuilder(
//         future: products,
//         builder: (context, AsyncSnapshot<List<Product>> snapshot) {
//           print('ProductList.build-snapshot.data?.length: ' + snapshot.data?.length.toString());
//           if (snapshot.connectionState == ConnectionState.done) {
//             var rows = List<Widget>();
//             for (var i = 0; i + 1 < snapshot.data.length; i += 2) {
//               rows.add(Row(
//                 children: <Widget>[
//                   Expanded(child: ProductBox(product: snapshot.data[i])),
//                   Expanded(child: ProductBox(product: snapshot.data[i + 1])),
//                 ],
//               ));

//               rows.add(SizedBox(
//                 height: 15,
//               ));
//             }

//             return Column(
//               children: rows,
//             );
//           } else
//             return Text("Yükleniyor");
//         },
//       ),
//     );
//   }
// }
