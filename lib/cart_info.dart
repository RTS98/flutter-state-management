import 'package:vanilla_state/cart_list_item.dart';

class CartInfo {
  final List<CartListItem> items;
  final int totalPrice;
  final int cartCount;

  CartInfo({
    required this.items,
    required this.totalPrice,
    required this.cartCount,
  });
}
