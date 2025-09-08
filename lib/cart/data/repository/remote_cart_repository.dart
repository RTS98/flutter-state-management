import 'dart:async';

import 'package:vanilla_state/cart/data/services/cart_api_service.dart';
import 'package:vanilla_state/cart/domain/models/cart_info.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class RemoteCartRepositoryImpl implements CartRepository {
  final StreamController<CartInfo> _stream =
      StreamController<CartInfo>.broadcast();
  final CartApiService _cartApiService;

  RemoteCartRepositoryImpl({
    required CartApiService cartApiService,
  }) : _cartApiService = cartApiService;

  @override
  Stream<CartInfo> get stream => _stream.stream;

  @override
  Future<void> addToCart(Product product) {
    return _cartApiService.addToCart(product);
  }

  @override
  Future<Iterable<CartListItem>> fetchCartItems() {
    return _cartApiService.fetchCartItems();
  }

  @override
  Future<void> removeFromCart(CartListItem item) {
    return _cartApiService.removeFromCart(item.product);
  }
}
