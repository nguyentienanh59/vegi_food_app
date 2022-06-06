import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:vegi_food_app/models/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
     num? cartPrice,
    int? cartQuantity,
    List<String>? cartUnit,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartPrice": cartPrice,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartQuantity": cartQuantity,
        "cartUnit": cartUnit,
        "isAdd": true,
        "status": "unpurchased",
      },
    );
  }

  void updateReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    num? cartPrice,
    int? cartQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartPrice": cartPrice,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartQuantity": cartQuantity,
        "isAdd": true,
      },
    );
  }

  List<ReviewCartModel> reviewCartDataList = [];
  Future<void> getRivewCartData() async {
    try {
      List<ReviewCartModel> newList = [];
      QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
          .collection("ReviewCart")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourReviewCart")
          .get();
      for (var element in reviewCartValue.docs) {
        final data = element.data() as Map<String, dynamic>;
        ReviewCartModel reviewCartModel = ReviewCartModel(
          cartUnit: data["cartUnit"] as List<dynamic>,
          cartId: data["cartId"] as String,
          cartImage: data["cartImage"] as String,
          cartPrice: data["cartPrice"] as int,
          cartName: data["cartName"] as String,
          cartQuantity: data["cartQuantity"] as int,
        );
        newList.add(reviewCartModel);
      }
      reviewCartDataList = [...newList];
      notifyListeners();
    } on Exception catch (_) {
      rethrow;
    }
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

  getTotalPrice() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice! * element.cartQuantity!;
    });
    return total;
  }

  void reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }

  Future<void> addPurchasedItem(ReviewCartModel item) async {
    FirebaseFirestore.instance
        .collection("purchasedHistory")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourPurchasedHistory")
        .add(
          item.toJson(),
        );
  }

  Future<void> finishPayment() async {
    await getRivewCartData();
    final items = reviewCartDataList;
    for (var item in items) {
      await addPurchasedItem(item);
    }
    final batch = FirebaseFirestore.instance.batch();
    final reviewCartItems = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .get();

    for (var reviewCartItem in reviewCartItems.docs) {
      batch.delete(reviewCartItem.reference);
    }
    await batch.commit();
    await getRivewCartData();
    notifyListeners();
  }
}
