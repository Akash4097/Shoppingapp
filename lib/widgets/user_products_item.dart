import 'package:flutter/material.dart';
import '../screens/edit_products_screen.dart';
class UserProductItem extends StatelessWidget {
  final String title;
  final String imgUrl;

  UserProductItem(this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => Navigator.of(context).pushNamed(EditProductsScreen.routeName),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
