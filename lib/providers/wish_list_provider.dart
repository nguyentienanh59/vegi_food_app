import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegi_food_app/models/product_model.dart';

class WishListProvider with ChangeNotifier {
  void addWishListData({
    String? wishListId,
    String? wishListName,
    String? wishListImage,
    num? wishListPrice,
    int? wishListQuantity,
    String? about,
    List<dynamic>? wishListUnit,
  }) async {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .set(
      {
        "wishListId": wishListId,
        "wishListPrice": wishListPrice,
        "wishListName": wishListName,
        "wishListImage": wishListImage,
        "wishListQuantity": wishListQuantity,
        "wishList": true,
        "about": about,
        "wishListUnit": wishListUnit,
      },
    );
  }

  Stream<List<ProductModel>> wishListStream() async* {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    yield* FirebaseFirestore.instance
        .collection("WishList")
        .doc(uid)
        .collection("YourWishList")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ProductModel(
          productId: data["wishListId"],
          productImage: data["wishListImage"],
          productName: data["wishListName"],
          productPrice: data["wishListPrice"],
          productQuantity: data["wishListQuantity"],
          productUnit: data["wishListUnit"],
          about: data["about"],
        );
      }).toList();
    });
  }

///// Get Wish List////////
  List<ProductModel> wishList = [];
  getWishListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .get();
    value.docs.forEach(
      (element) {
        final data = element.data() as Map<String, dynamic>;
        ProductModel productModel = ProductModel(
          productId: data["wishListId"],
          productImage: data["wishListImage"],
          productName: data["wishListName"],
          productPrice: data["wishListPrice"],
          productQuantity: data["wishListQuantity"],
          // productUnit: data["productUnit"],
          about: data["about"],
        );
        newList.add(productModel);
      },
    );
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishList {
    return wishList;
  }

  ////Delete Wish List/////
  deleteWishList(wishListId) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .delete();
  }
}
