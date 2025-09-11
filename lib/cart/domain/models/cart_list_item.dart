import 'package:vanilla_state/product/domain/models/product.dart';

class CartListItem {
  final Product product;
  final int quantity;

  CartListItem({
    required this.product,
    required this.quantity,
  });
}
