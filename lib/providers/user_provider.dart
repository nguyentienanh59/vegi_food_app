import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegi_food_app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    User? currentUser,
    String? userName,
    String? userEmail,
    String? userImage,
  }) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    if (uid.isNotEmpty) {
      await FirebaseFirestore.instance.collection("usersData").doc(uid).set(
        {
          "userName": userName,
          "userEmail": userEmail,
          "userImage": userImage,
          "userUid": uid,
        },
      );
    }
  }

  UserModel? currentData;
  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("usersData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("userEmail"),
        userImage: value.get("userImage"),
        userName: value.get("userName"),
        userUid: value.get("userUid"),
      );

      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel? get currenUserData {
    return currentData;
  }
}
