import 'package:flutter/material.dart';
import 'package:vanilla_state/product.dart';
import 'package:vanilla_state/product_list_item_view.dart';

class ProductsPage extends StatelessWidget {
  final Iterable<Product> products;

  const ProductsPage({
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) => ProductListItemView(
            productItem: products.elementAt(index),
          ),
        ),
      ),
    );
  }
}
