import 'package:flutter/material.dart';

import '../providers/product.dart';
import '../widgets/products_grid.dart';

class ProductOverViewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
      ),
      body: ProductsGrid(),
    );
  }
}
