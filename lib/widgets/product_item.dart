import 'package:flutter/material.dart';

import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(title),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
      ),
      child: GestureDetector(
        onTap: () =>
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName, arguments: id),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
