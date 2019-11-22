import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;

  CartItem(this.id, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: ListTile(
          leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FittedBox(child: Text("\$$price", style: TextStyle(color: Colors.white),)),
                ),
          ),
          title: Text(title),
          subtitle: Text("\$${quantity * price}"),
          trailing: Text("$quantity x"),
        ),
    );
  }
}
