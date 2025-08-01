import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/product_list_item.dart';

class ProductListItemView extends StatelessWidget {
  final ProductListItem productItem;
  final Function(CartListItem) onAddToCart;

  const ProductListItemView({
    super.key,
    required this.productItem,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(productItem.name),
        subtitle: Text(productItem.description),
        trailing: ElevatedButton(
          onPressed: () => onAddToCart(
            CartListItem(
              product: productItem,
              quantity: 1,
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
