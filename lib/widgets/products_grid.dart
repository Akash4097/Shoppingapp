import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products = productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (ctx, index) => ChangeNotifierProvider(
        builder: (context) => products[index],
        child: ProductItem(
//          id: products[index].id,
//          title: products[index].title,
//          imageUrl: products[index].imageUrl,
        ),
      ),
      itemCount: products.length,
    );
  }
}
