import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegi_food_app/models/product_model.dart';

class AllProductProvider extends ChangeNotifier {
  final _store = FirebaseFirestore.instance;

  Stream<List<ProductModel>> allHerbStream() {
    return _store
        .collection('HerbsProduct')
        .snapshots()
        .map<List<ProductModel>>((event) {
      return event.docs
          .map(
            (e) {
              var data = e.data();
              print(data['productQuantity']);
              return ProductModel(
              productImage: data['productImage'],
              productName: data['productName'],
              productPrice: data['productPrice'],
              about: data['about'],
              productId: data['productId'],
              productUnit: data['productUnit'],
              productQuantity: data['productQuantity'] ,
            );
            },
          )
          .toList();
    });
  }

  Stream<List<ProductModel>> allFreshStream() {
    return _store
        .collection('FreshProduct')
        .snapshots()
        .map<List<ProductModel>>((event) {
      return event.docs
          .map(
            (e) => ProductModel(
              productImage: e['productImage'],
              productName: e['productName'],
              productPrice: e['productPrice'],
              about: e['about'],
              productId: e['productId'],
              productUnit: e['productUnit'],
              productQuantity: e['productQuantity'],
            ),
          )
          .toList();
    });
  }

  Stream<List<ProductModel>> allRootStream() {
    return _store
        .collection('RootProduct')
        .snapshots()
        .map<List<ProductModel>>((event) {
      return event.docs
          .map(
            (e) => ProductModel(
              productImage: e['productImage'],
              productName: e['productName'],
              productPrice: e['productPrice'],
              about: e['about'],
              productId: e['productId'],
              productUnit: e['productUnit'],
              productQuantity: e['productQuantity'],
            ),
          )
          .toList();
    });
  }
}
