import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_view_model.dart';
import 'package:vanilla_state/cart_provider.dart';
import 'package:vanilla_state/product_list_item.dart';

class ProductListItemView extends StatelessWidget {
  final ProductListItem productItem;

  const ProductListItemView({
    super.key,
    required this.productItem,
  });

  @override
  Widget build(BuildContext context) {
    final CartViewModel cartViewModel = CartProvider.of(context).cartViewModel;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          productItem.name,
          style: const TextStyle(
            decoration: TextDecoration.none,
          ),
        ),
        subtitle: Text(
          productItem.description,
          style: const TextStyle(
            decoration: TextDecoration.none,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () => cartViewModel.addToCart(productItem),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
