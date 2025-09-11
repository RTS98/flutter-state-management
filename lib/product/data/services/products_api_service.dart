import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanilla_state/product/domain/models/product.dart';
import 'package:vanilla_state/products.dart';

class ProductsApiService {
  Future<Iterable<Product>> fetchProducts() async {
    try {
      final products =
          await FirebaseFirestore.instance.collection("products").get();

      return products.docs
          .map(
            (document) => Product(
              id: document.id,
              name: document['name'],
              description: document['description'],
              price: document['price'],
            ),
          )
          .toList();
    } catch (e) {
      return products;
    }
  }
}
