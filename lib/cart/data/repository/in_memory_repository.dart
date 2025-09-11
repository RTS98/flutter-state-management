import 'dart:async';

import 'package:vanilla_state/cart/domain/models/cart_info.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class InMemoryCartRepositoryImpl implements CartRepository {
  final Map<String, CartListItem> _items = <String, CartListItem>{};
  final StreamController<CartInfo> _stream =
      StreamController<CartInfo>.broadcast();

  @override
  Stream<CartInfo> get stream => _stream.stream;

  @override
  Future<void> addToCart(Product item) async {
    await Future.delayed(const Duration(seconds: 3));
    // Used the line below to simulate the execption case
    // throw Exception("Failed to add to cart");
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

  @override
  Future<void> removeFromCart(CartListItem item) async {
    await Future.delayed(const Duration(seconds: 3));
    // Used the line below to simulate the execption case
    // throw Exception("Failed to remove from cart");
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

  @override
  Future<Iterable<CartListItem>> fetchCartItems() async => _items.values;
}
