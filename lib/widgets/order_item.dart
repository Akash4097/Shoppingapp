import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orders;

  OrderItem(this.orders);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("\$${widget.orders.amount}"),
            subtitle: Text(
              DateFormat("dd MM yyyy hh:mm").format(widget.orders.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              height: min(widget.orders.products.length * 20.0 + 100, 200),
              child: ListView(
                children: <Widget>[
                  ...widget.orders.products
                      .map(
                        (product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              product.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${product.quantity}x\$${product.price}",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.green),
                            )
                          ],
                        ),
                      )
                      .toList()
                ],
              ),
            )
        ],
      ),
    );
  }
}
