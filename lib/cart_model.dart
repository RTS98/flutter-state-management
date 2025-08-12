import 'dart:async';

import 'package:vanilla_state/cart_info.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/product_list_item.dart';

class CartModel {
  final Map<String, CartListItem> _items = <String, CartListItem>{};
  final StreamController<CartInfo> _stream =
      StreamController<CartInfo>.broadcast();

  Stream<CartInfo> get stream => _stream.stream;

  Future<void> addToCart(ProductListItem item) async {
    await Future.delayed(const Duration(seconds: 3));
    _items.update(
      item.id,
      (item) => CartListItem(
        product: item.product,
        quantity: item.quantity + 1,
      ),
      ifAbsent: () => CartListItem(
        product: item,
        quantity: 1,
      ),
    );

    _addEventToStream();
  }

  Future<void> removeFromCart(CartListItem item) async {
    await Future.delayed(const Duration(seconds: 3));
    final cartItem = _items[item.product.id];

    if (cartItem == null) return;

    if (cartItem.quantity == 1) {
      _items.remove(cartItem.product.id);
    } else {
      _items.update(
        item.product.id,
        (item) => CartListItem(
          product: item.product,
          quantity: item.quantity - 1,
        ),
      );
    }

    _addEventToStream();
  }

  void dispose() => _stream.close();

  void _addEventToStream() => _stream.add(
        CartInfo(
          items: _items.values.toList(),
          totalPrice: _calculateTotalPrice(),
          cartCount: _calculatateCartCount(),
        ),
      );

  int _calculatateCartCount() => _items.entries.fold(
        0,
        (int count, item) => count + item.value.quantity,
      );

  int _calculateTotalPrice() => _items.values.fold(
        0,
        (int price, item) => price + item.product.price * item.quantity,
      );
}
