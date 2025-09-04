import 'package:vanilla_state/product.dart';
import 'package:vanilla_state/products_api_service.dart';

abstract interface class ProductRepository {
  Future<Iterable<Product>> fetchProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  final _productsApiService = ProductsApiService();

  @override
  Future<Iterable<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    return _productsApiService.fetchProducts();
  }
}
