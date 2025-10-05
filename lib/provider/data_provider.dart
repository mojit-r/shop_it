import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/model/product.dart';

class DataProvider extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  bool isInCart(Product product) {
    return _cartItems.contains(product);
  }

  void addItem(Product product) {
    if (!_cartItems.contains(product)) {
      _cartItems.add(product);
      saveCart();
      notifyListeners();
    }
  }

  void removeItem(Product product) {
    if (_cartItems.contains(product)) {
      _cartItems.remove(product);
      saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    saveCart();
    notifyListeners();
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJson =
        _cartItems.map((item) => jsonEncode(item.toMap())).toList();
    prefs.setStringList('cart', cartJson);
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartJson = prefs.getStringList('cart');
    if (cartJson != null) {
      _cartItems =
          cartJson.map((item) => Product.fromMap(jsonDecode(item))).toList();
      notifyListeners();
    }
  }
}
