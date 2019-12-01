import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/user_products_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_products_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products-screen";

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProductsFromServer(true);
  }

  @override
  Widget build(BuildContext context) {
//    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductsScreen.routeName),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshots) =>
            snapshots.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<ProductsProvider>(
                      builder: (ctx, productData, _) => ListView.builder(
                        itemBuilder: (_, index) => Column(
                          children: <Widget>[
                            UserProductItem(
                                productData.items[index].id,
                                productData.items[index].title,
                                productData.items[index].imageUrl),
                            Divider()
                          ],
                        ),
                        itemCount: productData.items.length,
                      ),
                    ),
                  ),
      ),
      drawer: AppDrawer(),
    );
  }
}
