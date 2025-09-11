import 'dart:async';

import 'package:hive/hive.dart';
import 'package:vanilla_state/cart/domain/models/cart_info.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class LocalCartRepository implements CartRepository {
  final StreamController<CartInfo> _stream =
      StreamController<CartInfo>.broadcast();
  final Box<CartListItem> _cartBox;

  LocalCartRepository({
    required final Box<CartListItem> cartBox,
  }) : _cartBox = cartBox;

  @override
  Future<void> addToCart(Product product) async {
    final cartItems = _cartBox
        .toMap()
        .entries
        .where((entry) => entry.value.product.id == product.id)
        .toList();

    if (cartItems.isEmpty) {
      await _cartBox.add(
        CartListItem(product: product, quantity: 1),
      );
      return;
    }

    await _cartBox.put(
      cartItems.first.key,
      CartListItem(
          product: product, quantity: cartItems.first.value.quantity + 1),
    );
  }

  @override
  Future<Iterable<CartListItem>> fetchCartItems() async {
    return _cartBox.values.toList();
  }

  @override
  Future<void> removeFromCart(CartListItem item) {
    final cartItems = _cartBox
        .toMap()
        .entries
        .where((entry) => entry.value.product.id == item.product.id)
        .toList();

    if (cartItems.isEmpty) {
      return Future.value(null);
    }

    if (cartItems.first.value.quantity == 1) {
      return _cartBox.delete(cartItems.first.key);
    }

    return _cartBox.put(
      cartItems.first.key,
      CartListItem(
        product: item.product,
        quantity: cartItems.first.value.quantity - 1,
      ),
    );
  }

  @override
  // TODO: implement stream
  Stream<CartInfo> get stream => _stream.stream;
}
