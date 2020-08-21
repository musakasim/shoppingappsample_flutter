import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shoppingappsampleflutter/ui/widgets/product_list.dart';

import 'dashboard.model.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardModel(),
      child: Consumer<DashboardModel>(
        builder: (context, model, child) => ProductList(),
      ),
    );
  }
}
