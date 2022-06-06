import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegi_food_app/models/product_model.dart';
import 'package:vegi_food_app/models/review_cart_model.dart';

class StatisticProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ProductModel> bestSellVegs = [];
  List<ProductModel> bestSellHerbs = [];
  List<ProductModel> bestSellRoots = [];

  double totalRevenue = 0;

  //list cac san pham da het
  List<ProductModel> outOfOrderProduct = [];

  Future<void> getBestSellVegs() async {
    bestSellVegs.clear();
    //add them field productSoldNum de luu so luong hang da ban cua 1 san pham
    //sau do lay san pham dua theo so luong ban
    var querySnapShot = await _firestore
        .collection("FreshProduct")
        .orderBy("productSoldNum",
            descending:
                true) // dung de sort theo so luong mua giam dan (10,9,8..)
        .limit(3) // gioi han la 3 mon do
        .get();
    querySnapShot.docs.forEach((element) {
      var productModel = ProductModel(
          productImage: element["productImage"],
          productName: element["productName"],
          productPrice: element["productPrice"],
          productId: element["productId"],
          productUnit: element["productUnit"],
          about: element["about"],
          productQuantity: element['productQuantity']);
      bestSellVegs.add(productModel);
    });
    print('best sell fresh: ${bestSellVegs.toList()}');
    notifyListeners();
  }

  Future<void> getBestSellHerbs() async {
    bestSellHerbs.clear();
    //add them field productSoldNum de luu so luong hang da ban cua 1 san pham
    //sau do lay san pham dua theo so luong ban
    var querySnapShot = await _firestore
        .collection("HerbsProduct")
        .orderBy("productSoldNum",
            descending:
                true) // dung de sort theo so luong mua giam dan (10,9,8..)
        .limit(3) // gioi han la 3 mon do
        .get();
    querySnapShot.docs.forEach((element) {
      var productModel = ProductModel(
          productImage: element["productImage"],
          productName: element["productName"],
          productPrice: element["productPrice"],
          productId: element["productId"],
          productUnit: element["productUnit"],
          about: element["about"],
          productQuantity: element['productQuantity']);
      bestSellHerbs.add(productModel);
    });
    print('best sell herb: ${bestSellHerbs.toList()}');
    notifyListeners();
  }

  Future<void> getBestSellRoots() async {
    bestSellRoots.clear();
    //add them field productSoldNum de luu so luong hang da ban cua 1 san pham
    //sau do lay san pham dua theo so luong ban
    var querySnapShot = await _firestore
        .collection("RootProduct")
        .orderBy("productSoldNum",
            descending:
                true) // dung de sort theo so luong mua giam dan (10,9,8..)
        .limit(3) // gioi han la 3 mon do
        .get();
    querySnapShot.docs.forEach((element) {
      var productModel = ProductModel(
          productImage: element["productImage"],
          productName: element["productName"],
          productPrice: element["productPrice"],
          productId: element["productId"],
          productUnit: element["productUnit"],
          about: element["about"],
          productQuantity: element['productQuantity']);
      bestSellRoots.add(productModel);
    });
    print('best sell root: ${bestSellRoots.toList()}');
    notifyListeners();
  }

  Future<void> getOutOfOrderProducts() async {
    outOfOrderProduct.clear();
    var querySnapShot = await _firestore
        .collection("RootProduct")
        .where(
          "productQuantity",
          isLessThanOrEqualTo: 0,
        ) //tim kiem theo quantity duoi hoac bang 0
        .get();
    querySnapShot.docs.forEach((element) {
      var productModel = ProductModel(
          productImage: element["productImage"],
          productName: element["productName"],
          productPrice: element["productPrice"],
          productId: element["productId"],
          productUnit: element["productUnit"],
          about: element["about"],
          productQuantity: element['productQuantity']);
      outOfOrderProduct.add(productModel);
    });

    querySnapShot = await _firestore
        .collection("HerbsProduct")
        .where("productQuantity",
            isLessThanOrEqualTo: 0) //tim kiem theo quantity duoi hoac bang 0
        .get();
    querySnapShot.docs.forEach((element) {
      var productModel = ProductModel(
          productImage: element["productImage"],
          productName: element["productName"],
          productPrice: element["productPrice"],
          productId: element["productId"],
          productUnit: element["productUnit"],
          about: element["about"],
          productQuantity: element['productQuantity']);
      outOfOrderProduct.add(productModel);
    });

    querySnapShot = await _firestore
        .collection("FreshProduct")
        .where("productQuantity",
            isLessThanOrEqualTo: 0) //tim kiem theo quantity duoi hoac bang 0
        .get();
    querySnapShot.docs.forEach((element) {
      var productModel = ProductModel(
          productImage: element["productImage"],
          productName: element["productName"],
          productPrice: element["productPrice"],
          productId: element["productId"],
          productUnit: element["productUnit"],
          about: element["about"],
          productQuantity: element['productQuantity']);
      outOfOrderProduct.add(productModel);
    });

    print('list out of order: ${outOfOrderProduct.toList()}');
    notifyListeners();
  }

  Stream<num> getTotalRevenue(String name) {
    // nay lay theo so luong ban vs gia cua tung san pham
    num total = 0;
    return _firestore.collection(name).snapshots().map((event) {
      event.docs.forEach((e) {
        var data = e.data();
        num soldNum = data['productSoldNum'];
        num price = data['productPrice'];
        double discout = 30;
        double discoutVaule = (price * discout) / 100;
        total = total + soldNum * (price - discoutVaule);
      });
      return total;
    });
  }

  Stream<int> getTotalUser() {
    return _firestore.collection('usersData').snapshots().map((event) {
      return event.docs.length;
    });
  }

  Stream<List<ProductModel>> herbStream() {
    return _firestore.collection('HerbsProduct').snapshots().map((event) {
      return event.docs.map((e) {
        var data = e.data();
        ProductModel product = ProductModel(
            productImage: data['productImage'],
            productName: data['productName'],
            productPrice: data['productPrice'],
            about: data['about'],
            productQuantity: data['productQuantity'],
            productUnit: data['productUnit'],
            productId: data['productId'],
            cartQuantity: data['cartQuantity']);
        return product;
      }).toList();
    });
  }

  Stream<List<ProductModel>> rootStream() {
    return _firestore.collection('RootProduct').snapshots().map((event) {
      return event.docs.map((e) {
        var data = e.data();
        ProductModel product = ProductModel(
            productImage: data['productImage'],
            productName: data['productName'],
            productPrice: data['productPrice'],
            about: data['about'],
            productQuantity: data['productQuantity'],
            productUnit: data['productUnit'],
            productId: data['productId'],
            cartQuantity: data['cartQuantity']);
        return product;
      }).toList();
    });
  }

  Stream<List<ProductModel>> freshStream() {
    return _firestore.collection('FreshProduct').snapshots().map((event) {
      return event.docs.map((e) {
        var data = e.data();
        ProductModel product = ProductModel(
            productImage: data['productImage'],
            productName: data['productName'],
            productPrice: data['productPrice'],
            about: data['about'],
            productQuantity: data['productQuantity'],
            productUnit: data['productUnit'],
            productId: data['productId'],
            cartQuantity: data['cartQuantity']);
        return product;
      }).toList();
    });
  }

  Stream<int> freshSoldNum() {
    return _firestore.collection('FreshProduct').snapshots().map((event) {
      int count = 0;
      var list = event.docs.map<int>((e) {
        return e.data()['productSoldNum'];
      }).toList();
      list.forEach((element) {
        count = count + element;
      });
      return count;
    });
  }

  Stream<int> rootSoldNum() {
    return _firestore.collection('RootProduct').snapshots().map((event) {
      int count = 0;
      var list = event.docs.map<int>((e) {
        print('root: ${e.data()['productSoldNum']}');
        return e.data()['productSoldNum'];
      }).toList();
      list.forEach((element) {
        count = count + element;
      });
      return count;
    });
  }

  Stream<int> herbsSoldNum() {
    return _firestore.collection('HerbsProduct').snapshots().map((event) {
      int count = 0;
      var list = event.docs.map<int>((e) {
        return e.data()['productSoldNum'];
      }).toList();
      list.forEach((element) {
        count = count + element;
      });
      return count;
    });
  }
}
