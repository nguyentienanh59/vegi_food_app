import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegi_food_app/screens/all_product/category.dart';

class SingleProductProvider extends ChangeNotifier {
  final _store = FirebaseFirestore.instance;

  void changeName({required String uid, required String newName,required Category category}) async {
    if (category != null) {
      _store.collection(cateName(category)).doc(uid).update({'productName': newName});
    }
  }

  String cateName(Category category) {
    switch (category) {
      case Category.fresh:
        return 'FreshProduct';
      case Category.herb:
        return 'HerbsProduct';
      case Category.root:
        return 'RootProduct';
      default:
        return '';
    }
  }

  Future<void> updateProduct(
      {required Category category,
        required String productId,
      required String productName,
      required num productPrice,
      required int productQuantity,
      required String about}) async {
    _store.collection(cateName(category)).doc(productId).update({
      'productName':productName,
      'productPrice':productPrice,
      'productQuantity':productQuantity,
      'about':about,
    });
  }


  Stream<int> getProductSold(String id,Category category){
    return _store.collection(cateName(category)).doc(id.trim()).snapshots().map((event) {
      return event.data()!['productSoldNum'];
    });
  }
}
