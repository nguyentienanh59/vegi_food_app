import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vegi_food_app/models/delivery_address_model.dart';

class CheckoutProvider with ChangeNotifier {
  bool isLoadding = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController soiety = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landMark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  TextEditingController pinCode = TextEditingController();

  double? lat;
  double? lng;

  String get locationCoordinates {
    if (lat == null || lng == null) {
      return "Set Location";
    }
    return "$lat, $lng";
  }

  void setLocation(double? lat, double? lng) {
    this.lat = lat;
    this.lng = lng;
    notifyListeners();
  }

  void validator(context, myType) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "First Name is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Last Name is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "Mobile No is empty");
    } else if (alternateMobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "AlternateMobileNo is empty");
    } else if (soiety.text.isEmpty) {
      Fluttertoast.showToast(msg: "Society is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "Street is empty");
    } else if (landMark.text.isEmpty) {
      Fluttertoast.showToast(msg: "Landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "City is empty");
    } else if (aera.text.isEmpty) {
      Fluttertoast.showToast(msg: "Aera is empty");
    } else if (pinCode.text.isEmpty) {
      Fluttertoast.showToast(msg: "Passcode is empty");
    } else {
      isLoadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": firstName.text,
        "lastName": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "soiety": soiety.text,
        "street": street.text,
        "landMark": landMark.text,
        "city": city.text,
        "aera": aera.text,
        "pinCode": pinCode.text,
        "addressType": myType.toString(),
        "latitude": lat,
        "longitude": lng,
      }).then((value) async {
        isLoadding = false;
        await Fluttertoast.showToast(msg: "Add your delivery address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];

  Stream<DeliveryAddressModel?> get deliveryAddressStream {
    return FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map(
      (event) {
        if (event.exists) {
          final data = event.data() as Map<String, dynamic>;
          return DeliveryAddressModel(
            firstName: data["firstName"],
            lastName: data["lastName"],
            addressType: data["addressType"],
            mobileNo: data["mobileNo"],
            alternateMobileNo: data["alternateMobileNo"],
            aera: data["aera"],
            landMark: data["landMark"],
            street: data["street"],
            city: data["city"],
            pinCode: data["pinCode"],
            soiety: data["soiety"],
          );
        }
        return null;
      },
    );
  }

  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel? deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstName"),
        lastName: _db.get("lastName"),
        addressType: _db.get("addressType"),
        aera: _db.get("aera"),
        mobileNo: _db.get("mobileNo"),
        alternateMobileNo: _db.get("alternateMobileNo"),
        landMark: _db.get("landMark"),
        street: _db.get("street"),
        city: _db.get("city"),
        pinCode: _db.get("pinCode"),
        soiety: _db.get("soiety"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAddressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }
}
