import 'dart:async';

import 'package:vanilla_state/cart/data/services/cart_api_service.dart';
import 'package:vanilla_state/cart/domain/models/cart_info.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class RemoteCartRepository implements CartRepository {
  final StreamController<CartInfo> _stream =
      StreamController<CartInfo>.broadcast();
  final CartApiService _cartApiService;

  RemoteCartRepository({
    required CartApiService cartApiService,
  }) : _cartApiService = cartApiService;

  @override
  Stream<CartInfo> get stream => _stream.stream;

  @override
  Future<void> addToCart(Product product) async {
    print("REMOTE");
    await _cartApiService.addToCart(product);

    final items = await fetchCartItems();

    _addEventToStream(items);
  }

  @override
  Future<Iterable<CartListItem>> fetchCartItems() async {
    final items = await _cartApiService.fetchCartItems();
    _addEventToStream(items);

    return items;
  }

  @override
  Future<void> removeFromCart(CartListItem item) async {
    await _cartApiService.removeFromCart(item.product);

    final items = await fetchCartItems();

    _addEventToStream(items);
  }

  Future<void> addMultipleCartItems(Iterable<CartListItem> items) async {
    return _cartApiService.addItemsToCart(items);
  }

  void _addEventToStream(Iterable<CartListItem> items) => _stream.add(
        CartInfo(
          items: items.toList(),
          totalPrice: _calculateTotalPrice(items),
          cartCount: _calculatateCartCount(items),
        ),
      );

  int _calculatateCartCount(Iterable<CartListItem> items) => items.fold(
        0,
        (int count, item) => count + item.quantity,
      );

  int _calculateTotalPrice(Iterable<CartListItem> items) => items.fold(
        0,
        (int price, item) => price + item.product.price * item.quantity,
      );
}
