import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/cart_view_model.dart';
import 'package:vanilla_state/cart_provider.dart';

class CartListItemView extends StatelessWidget {
  final CartListItem item;

  const CartListItemView({
    super.key,
    required this.item,
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
        title: Text(item.product.name),
        subtitle: Text(item.product.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => cartViewModel.addToCart(item.product),
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () => cartViewModel.removeFromCart(item),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
