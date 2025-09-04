import 'package:hive/hive.dart';
import 'package:vanilla_state/product.dart';
import 'package:vanilla_state/products_api_service.dart';

abstract interface class ProductRepository {
  Future<Iterable<Product>> fetchProducts();
}

class ProductRepositoryImpl extends ProductRepository {
  final RemoteProductRepository _remoteProductRepository;
  final LocalProductRepository _localProductRepository;

  ProductRepositoryImpl({
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

class LocalProductRepository implements ProductRepository {
  final Box<Product> _productBox;

  LocalProductRepository({
    required Box<Product> productBox,
  }) : _productBox = productBox;

  @override
  Future<Iterable<Product>> fetchProducts() async {
    return _productBox.values.toList();
  }

  Future<void> addProducts(Iterable<Product> products) async =>
      _productBox.addAll(products);
}
