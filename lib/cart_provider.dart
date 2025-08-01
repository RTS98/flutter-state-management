import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_notifier.dart';

class CartProvider extends InheritedWidget {
  final CartNotifier cartNotifier;

  const CartProvider({
    super.key,
    required super.child,
    required this.cartNotifier,
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
    return cartNotifier != oldWidget.cartNotifier;
  }
}
