import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vegi_food_app/models/user_model.dart';

class AllUserProvider extends ChangeNotifier {
  final _store = FirebaseFirestore.instance;
  BehaviorSubject<List<UserModel>> _userFetcher = BehaviorSubject.seeded([]);

  Stream<List<UserModel>> get userStream => _userFetcher.stream;


  Future<void> getAllUser() async {
    var collection = await _store.collection("usersData").get();
    List<UserModel> list = [];
    collection.docs.forEach((element) {
      list.add(UserModel(userEmail: element['userEmail'],
          userImage: element['userImage'],
          userName: element['userName'],
          userUid: element['userUid']));
    });
    _userFetcher.sink.add(list);
    notifyListeners();
  }

  Future<void> deleteUser(String uid) async {
    notifyListeners();
    await _store.collection("usersData").doc(uid).delete();
    await getAllUser();
    notifyListeners();
  }
}
