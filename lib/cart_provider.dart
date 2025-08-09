import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_view_model.dart';

class CartProvider extends InheritedWidget {
  final CartViewModel cartViewModel;

  const CartProvider({
    super.key,
    required super.child,
    required this.cartViewModel,
  });

  static CartProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>();
  }

  static CartProvider of(BuildContext context) {
    final CartProvider? result = maybeOf(context);

    assert(result != null, "No CartNotifier was found in context");

    return result!;
  }

  @override
  bool updateShouldNotify(covariant CartProvider oldWidget) {
    return cartViewModel != oldWidget.cartViewModel;
  }
}
