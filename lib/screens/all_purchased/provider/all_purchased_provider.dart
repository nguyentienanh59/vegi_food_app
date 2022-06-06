import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AllPurchasedProvider extends ChangeNotifier{
  final _store = FirebaseFirestore.instance;

  Stream<List<String>> getAllPurchased(){
    return _store.collection('purchasedHistory').snapshots().map((event) {
      return event.docs.map((e) => e.id).toList();
    });
  }
  
  Future<String> getUserName(String id) async{
    var data = await _store.collection('usersData').doc(id).get();
    print(data.data());
    return data.data()!['userName'];
  }
}