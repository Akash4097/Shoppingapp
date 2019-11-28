import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = "/edit-products";

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formState = GlobalKey<FormState>();
  var _editingProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');
  var _init = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  var _isLoding = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      if (productId != null) {
        _editingProduct =
            Provider.of<ProductsProvider>(context).findById(productId);
        _initValues = {
          'title': _editingProduct.title,
          'description': _editingProduct.description,
          'price': _editingProduct.price.toString(),
          'imageUrl': ''
        };
        _imageController.text = _editingProduct.imageUrl;
      }
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageController.text.startsWith("http") &&
          !_imageController.text.startsWith("https"))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _formState.currentState.validate();

    if (!_isValid) {
      return;
    }
    _formState.currentState.save();
    setState(() {
      _isLoding = true;
    });
    if (_editingProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editingProduct.id, _editingProduct);
      setState(() {
        _isLoding = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editingProduct)
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An Error Occured!"),
            content: Text("Something went worng"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      }).then((_) {
        setState(() {
          _isLoding = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
        ],
      ),
      body: _isLoding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formState,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editingProduct = Product(
                            id: _editingProduct.id,
                            title: value,
                            price: _editingProduct.price,
                            description: _editingProduct.description,
                            imageUrl: _editingProduct.imageUrl,
                            isFavorite: _editingProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a valid title";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: "Price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editingProduct = Product(
                            id: _editingProduct.id,
                            title: _editingProduct.title,
                            price: double.parse(value),
                            description: _editingProduct.description,
                            imageUrl: _editingProduct.imageUrl,
                            isFavorite: _editingProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a price";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number.";
                        }
                        if (double.parse(value) <= 0) {
                          return "Please enter a number greater than zero";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      maxLines: 3,
                      decoration: InputDecoration(labelText: "Description"),
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editingProduct = Product(
                            id: _editingProduct.id,
                            title: _editingProduct.title,
                            price: _editingProduct.price,
                            description: value,
                            imageUrl: _editingProduct.imageUrl,
                            isFavorite: _editingProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter some description.";
                        }
                        if (value.length < 10) {
                          return "Please enter description longer than 10 characters";
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: FittedBox(
                            child: _imageController.text.isEmpty
                                ? Text("Enter Url")
                                : Image.network(
                                    _imageController.text,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Image Url"),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            focusNode: _imageUrlFocusNode,
                            controller: _imageController,
                            onSaved: (value) {
                              _editingProduct = Product(
                                  id: _editingProduct.id,
                                  title: _editingProduct.title,
                                  price: _editingProduct.price,
                                  description: _editingProduct.description,
                                  imageUrl: value,
                                  isFavorite: _editingProduct.isFavorite);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter a image URL.";
                              }
                              if (!value.startsWith("http") &&
                                  !value.startsWith("https")) {
                                return "Please enter a valid Url";
                              }
//                        if (!value.endsWith(".png") &&
//                            !value.endsWith(".jpg") &&
//                            !value.endsWith(".jpeg")) {
//                          return "Please enter a valid image";
//                        }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
