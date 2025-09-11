import 'package:vanilla_state/product/domain/models/product.dart';

class ProductState {
  final Iterable<Product> products;
  final int cartCount;
  final Exception? exception;
  final bool isProcessing;

  ProductState({
    required this.products,
    required this.cartCount,
    this.exception,
    required this.isProcessing,
  });

  ProductState copyWith({
    Iterable<Product>? products,
    Exception? exception,
    bool isProcessing = false,
    int? cartCount
  }) {
    return ProductState(
      products: products ?? this.products,
      cartCount: cartCount ?? this.cartCount,
      exception: exception,
      isProcessing: isProcessing,
    );
  }
}
