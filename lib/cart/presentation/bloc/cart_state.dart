import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';

class CartState {
  final List<CartListItem> items;
  final int totalPrice;
  final int cartCount;
  final bool? isProcessing;
  final Exception? error;

  CartState({
    required this.items,
    required this.totalPrice,
    required this.cartCount,
    this.isProcessing,
    this.error,
  });

  CartState copyWith({
    List<CartListItem>? items,
    int? totalPrice,
    int? cartCount,
    bool? isProcessing,
    Exception? error,
  }) {
    return CartState(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      cartCount: cartCount ?? this.cartCount,
      isProcessing: isProcessing,
      error: error,
    );
  }
}
