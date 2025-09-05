import 'package:vanilla_state/product/data/repository/local_product_repository.dart';
import 'package:vanilla_state/product/data/repository/remote_product_repository.dart';
import 'package:vanilla_state/product/domain/models/product.dart';
import 'package:vanilla_state/product/domain/repository/product_repository.dart';

class AppProductRepositoryImpl implements ProductRepository {
  final RemoteProductRepository _remoteProductRepository;
  final LocalProductRepository _localProductRepository;

  AppProductRepositoryImpl({
    required RemoteProductRepository remoteProductRepository,
    required LocalProductRepository localProductRepository,
  })  : _remoteProductRepository = remoteProductRepository,
        _localProductRepository = localProductRepository;

  @override
  Future<Iterable<Product>> fetchProducts() async {
    final localProducts = await _localProductRepository.fetchProducts();

    if (localProducts.isNotEmpty) {
      return localProducts;
    }

    final products = await _remoteProductRepository.fetchProducts();

    await _localProductRepository.addProducts(products);

    return products;
  }
}
