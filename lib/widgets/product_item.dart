import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(product.title),
        leading: Consumer<Product>(
          builder: (ctx, product, child) => IconButton(
            color: Theme.of(context).accentColor,
            onPressed: () => product.toggleFavoriteStatus(),
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ),
        trailing: IconButton(
          color: Theme.of(context).accentColor,
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
        ),
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product.id),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
