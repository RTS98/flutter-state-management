import 'package:vanilla_state/cart/domain/models/cart_info.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

abstract interface class CartRepository {
  Stream<CartInfo> get stream;
  Future<void> addToCart(Product product);
  Future<void> removeFromCart(CartListItem item);
  Future<Iterable<CartListItem>> fetchCartItems();
}
