import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

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
          onPressed: () {
            cart.addItem(product.id, product.price, product.title);
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Added Item to the cart!"),
                action: SnackBarAction(
                  label: "UNDO",
                  onPressed: () => cart.removeSingleItem(product.id),
                ),
              ),
            );
          },
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
