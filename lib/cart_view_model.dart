import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_info.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/cart_model.dart';
import 'package:vanilla_state/product_list_item.dart';

class CartViewModel extends ChangeNotifier {
  final CartModel _cartModel = CartModel();

  CartInfo _state = CartInfo(
    items: {},
    totalPrice: 0,
    cartCount: 0,
  );

  CartInfo get state => _state;

  CartViewModel() {
    _cartModel.stream.listen((cartInfo) {
      _state = CartInfo(
        items: cartInfo.items,
        totalPrice: cartInfo.totalPrice,
        cartCount: cartInfo.cartCount,
      );

      notifyListeners();
    });
  }

  void addToCart(ProductListItem item) => _cartModel.addToCart(item);

  void removeFromCart(CartListItem item) => _cartModel.removeFromCart(item);
}
