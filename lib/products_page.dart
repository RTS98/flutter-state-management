import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/product_list_item_view.dart';
import 'package:vanilla_state/products.dart';

class ProductsPage extends StatefulWidget {
  final Function(CartListItem) onAddToCart;

  const ProductsPage({
    super.key,
    required this.onAddToCart,
  });

  @override
  State<StatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) => ProductListItemView(
            onAddToCart: widget.onAddToCart,
            productItem: products[index],
          ),
        ),
      ),
    );
  }
}
