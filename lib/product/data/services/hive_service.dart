import 'package:hive_flutter/hive_flutter.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class HiveService {
  Box<Product> getProductBox() => Hive.box<Product>('products');

  Box<CartListItem> getCartBox() => Hive.box<CartListItem>("cart");

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(CartAdapter());
    await Hive.openBox<Product>('products');
    await Hive.openBox<CartListItem>('cart');
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

class CartAdapter extends TypeAdapter<CartListItem> {
  @override
  CartListItem read(BinaryReader reader) {
    return CartListItem(
      product: reader.read(),
      quantity: reader.read(),
    );
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, CartListItem cartItem) {
    writer
      ..write(cartItem.product)
      ..write(cartItem.quantity);
  }
}
