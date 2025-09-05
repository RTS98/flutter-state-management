import 'package:vanilla_state/product/data/services/products_api_service.dart';
import 'package:vanilla_state/product/domain/models/product.dart';
import 'package:vanilla_state/product/domain/repository/product_repository.dart';

class RemoteProductRepository implements ProductRepository {
  final ProductsApiService _productsApiService;

  RemoteProductRepository({
    required ProductsApiService productsApiService,
  }) : _productsApiService = productsApiService;

  @override
  Future<Iterable<Product>> fetchProducts() async {
    return _productsApiService.fetchProducts();
  }
}
