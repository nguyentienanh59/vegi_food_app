import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegi_food_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    final data = element.data() as Map<String, dynamic>;
    productModel = ProductModel(
      productImage: data["productImage"],
      productName: data["productName"],
      productPrice: data["productPrice"],
      productId: data["productId"],
      productUnit: data["productUnit"],
      about: data["about"],
      productQuantity: data['productQuantity']
    );
    search.add(productModel!);
  }

  List<ProductModel> herbsProductList = [];
  fatchHerbsProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    herbsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }

  //-----------------------------------------//
  List<ProductModel> freshProductList = [];
  fatchFreshProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FreshProduct").get();

    for (var element in value.docs) {
      productModels(element);

      newList.add(productModel!);
    }
    freshProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshProductDataList {
    return freshProductList;
  }

  // ------------------------------------//
  List<ProductModel> rootProductList = [];
  fatchRootProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("RootProduct").get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    rootProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getRootProductDataList {
    return rootProductList;
  }

  //----------------------------------//
  List<ProductModel> get getAllProductSearch {
    log(search.map((e) => e.productName).toList().toString());
    return search;
  }
}
