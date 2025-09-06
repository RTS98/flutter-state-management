import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class CartApiService {
  Future<Iterable<CartListItem>> fetchCartItems() async {
    try {
      final cartItems =
          await FirebaseFirestore.instance.collection("cart").get();
      return cartItems.docs
          .map(
            (element) => CartListItem(
              product: Product(
                id: element['id'],
                name: element['name'],
                description: element['description'],
                price: element['price'],
              ),
              quantity: element['quantity'],
            ),
          )
          .toList();
    } on Error catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<void> addToCart(Product product) async {
    try {
      await FirebaseFirestore.instance.collection("cart").doc(product.id).set(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'quantity': FieldValue.increment(1),
        },
        SetOptions(merge: true),
      );
    } on Error catch (e) {
      print(e.toString());
    }
  }

  Future<void> removeFromCart(Product product) async {
    final docRef =
        FirebaseFirestore.instance.collection("cart").doc(product.id);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final doc = await transaction.get(docRef);

        if (doc.data()?['quantity'] == 1) {
          return docRef.delete();
        }

        await docRef.update(
          {
            "quatity": FieldValue.increment(-1),
          },
        );
      });
    } on Error catch (e) {
      print(e.toString());
    }
  }
}
