import 'package:vanilla_state/product_list_item.dart';

class CartListItem {
  final ProductListItem product;
  final int quantity;

  CartListItem({
    required this.product,
    required this.quantity,
  });
}
