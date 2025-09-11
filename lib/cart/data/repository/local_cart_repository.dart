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
    final cartItems = _cartBox.values.indexed
        .where(
          ((int, CartListItem) index) => index.$2.product.id == product.id,
        )
        .toList();

    if (cartItems.isEmpty) {
      await _cartBox.add(
        CartListItem(product: product, quantity: 1),
      );
      return;
    }

    await _cartBox.put(
      cartItems.first.$1,
      CartListItem(product: product, quantity: cartItems.first.$2.quantity + 1),
    );
  }

  @override
  Future<Iterable<CartListItem>> fetchCartItems() async {
    print(_cartBox.values.toList().first.quantity);
    return _cartBox.values.toList();
  }

  @override
  Future<void> removeFromCart(CartListItem item) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }

  @override
  // TODO: implement stream
  Stream<CartInfo> get stream => _stream.stream;
}
