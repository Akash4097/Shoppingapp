import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return ListView.builder(
      itemBuilder: (context, index) => OrderItem(ordersData.orders[index]),
      itemCount: ordersData.orders.length,
    );
  }
}
