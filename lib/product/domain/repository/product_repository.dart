import 'package:vanilla_state/product/domain/models/product.dart';

abstract interface class ProductRepository {
  Future<Iterable<Product>> fetchProducts();
}