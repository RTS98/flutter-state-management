import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';

class CartNotifier extends ChangeNotifier {
  final Map<String, CartListItem> _items = <String, CartListItem>{};
  int _cartCount = 0;
  int _totalPrice = 0;

  int get cartCount => _cartCount;
  Map<String, CartListItem> get items => _items;
  int get totalPrice => _totalPrice;

  void addToCart(CartListItem item) {
    items.update(
      item.product.id,
      (item) => CartListItem(
        product: item.product,
        quantity: item.quantity + 1,
      ),
      ifAbsent: () => item,
    );

    _calculatateCartCount();
    _calculateTotalPrice();
    notifyListeners();
  }

  void removeFromCart(CartListItem item) {
    final cartItem = items[item.product.id];

    if (cartItem == null) return;

    if (cartItem.quantity == 1) {
      items.remove(cartItem.product.id);
    } else {
      items.update(
        item.product.id,
        (item) => CartListItem(
          product: item.product,
          quantity: item.quantity - 1,
        ),
      );
    }

    _calculatateCartCount();
    _calculateTotalPrice();
    notifyListeners();
  }

  void _calculatateCartCount() => _cartCount = items.entries.fold(
        0,
        (int count, item) => count + item.value.quantity,
      );

  void _calculateTotalPrice() => _totalPrice = items.values.fold(
        0,
        (int price, item) => price + item.product.price * item.quantity,
      );
}
