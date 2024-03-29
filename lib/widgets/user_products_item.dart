import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_products_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  UserProductItem(this.id, this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context)
                  .pushNamed(EditProductsScreen.routeName, arguments: id),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context)
                      .deleteProduct(id);
                  scaffold
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          "A Product Deleted!",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text(
                      "Deleting failed",
                      textAlign: TextAlign.center,
                    ),
                  ));
                }
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
