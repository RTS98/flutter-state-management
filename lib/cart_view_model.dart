import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/cart_model.dart';
import 'package:vanilla_state/cart_state.dart';
import 'package:vanilla_state/product_list_item.dart';

class CartViewModel extends ChangeNotifier {
  final CartModel _cartModel = CartModel();

  CartState _state = CartState(
    items: [],
    totalPrice: 0,
    cartCount: 0,
  );

  CartState get state => _state;

  CartViewModel() {
    _cartModel.stream.listen((cartInfo) {
      _state = CartState(
        items: cartInfo.items,
        totalPrice: cartInfo.totalPrice,
        cartCount: cartInfo.cartCount,
      );

      notifyListeners();
    });
  }

  Future<void> addToCart(ProductListItem item) async {
    _state = _state.copyWith(isProcessing: true);
    notifyListeners();

    try {
      await _cartModel.addToCart(item);
      _state = _state.copyWith(isProcessing: false);
    } on Exception catch (e) {
      _state = _state.copyWith(error: e, isProcessing: false);
    }

    notifyListeners();
  }

  Future<void> removeFromCart(CartListItem item) async {
    _state = _state.copyWith(isProcessing: true);
    notifyListeners();

    try {
      await _cartModel.removeFromCart(item);
      _state = _state.copyWith(isProcessing: false);
    } on Exception catch (e) {
      _state = _state.copyWith(error: e, isProcessing: false);
    }

    notifyListeners();
  }

  void clearError() {
    _state = _state.copyWith(error: null);
    notifyListeners();
  }
}
