import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products_provider.dart';

enum FilterOptions { Favorites, All }

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _showFavorites = false;
  var _initState = true;
  var _isLoading = false;

  Future<void> _refreshProducts() async {
    await Provider.of<ProductsProvider>(context).fetchProductsFromServer();
  }

  @override
  void didChangeDependencies() {
    if (_initState) {
      setState(() {
        _isLoading = true;
      });
      _refreshProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _initState = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Show Favorites"),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch,
              value: cart.itemsCount.toString(),
            ),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(_showFavorites),
      ),
      drawer: AppDrawer(),
    );
  }
}
