import 'package:hive_flutter/hive_flutter.dart';
import 'package:vanilla_state/product.dart';

class HiveService {
  Box<Product> getProductBox() {
    return Hive.box<Product>('products');
  }

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    await Hive.openBox<Product>('products');
  }
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  int get typeId => 0;

  @override
  Product read(BinaryReader reader) {
    return Product(
      id: reader.read(),
      name: reader.read(),
      description: reader.read(),
      price: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Product product) {
    writer
      ..write(product.id)
      ..write(product.name)
      ..write(product.description)
      ..write(product.price);
  }
}
