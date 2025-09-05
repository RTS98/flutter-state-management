import 'package:hive/hive.dart';
import 'package:vanilla_state/product/domain/models/product.dart';
import 'package:vanilla_state/product/domain/repository/product_repository.dart';


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