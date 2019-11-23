import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final String title;
  final int quantity;

  CartItem(this.id, this.productId, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
      ),
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).deleteItem(productId),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("Do you want to remove the item form the cart?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () => Navigator.of(context).pop(true),
                  )
                ],
              );
            });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(
                  child: Text(
                "\$$price",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          title: Text(title),
          subtitle: Text("\$${quantity * price}"),
          trailing: Text("$quantity x"),
        ),
      ),
    );
  }
}
