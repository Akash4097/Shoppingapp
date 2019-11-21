import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_details_screen.dart';
import './providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProductsProvider(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.deepOrange,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen()
        },
      ),
    );
  }
}
