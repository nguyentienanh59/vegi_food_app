import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/check_out_provider.dart';
import 'package:vegi_food_app/screens/google_map/google_map.dart';
import 'package:vegi_food_app/widgets/custom_text_field.dart';

class AddDeliverAdress extends StatefulWidget {
  @override
  State<AddDeliverAdress> createState() => _AddDeliverAdressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliverAdressState extends State<AddDeliverAdress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(
    BuildContext context,
  ) {
    CheckoutProvider? checkoutProvider = Provider.of<CheckoutProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Delivery Address",
            style: TextStyle(color: textColor, fontSize: 18),
          ),
          iconTheme: IconThemeData(color: textColor),
          backgroundColor: primaryColor,
        ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 48,
            child: checkoutProvider.isLoadding == false
                ? MaterialButton(
                    onPressed: () {
                      checkoutProvider.validator(context, myType);
                    },
                    child: Text(
                      "Add Address",
                      style: TextStyle(color: textColor),
                    ),
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              CustomTextField(
                labText: "First name",
                controller: checkoutProvider.firstName,
              ),
              CustomTextField(
                labText: "Last name",
                controller: checkoutProvider.lastName,
              ),
              CustomTextField(
                labText: "Mobile Phone",
                controller: checkoutProvider.mobileNo,
              ),
              CustomTextField(
                labText: "Alternate Mobile No",
                controller: checkoutProvider.alternateMobileNo,
              ),
              CustomTextField(
                labText: "Scoiety",
                controller: checkoutProvider.soiety,
              ),
              CustomTextField(
                labText: "Street",
                controller: checkoutProvider.street,
              ),
              CustomTextField(
                labText: "Landmark",
                controller: checkoutProvider.landMark,
              ),
              CustomTextField(
                labText: "City",
                controller: checkoutProvider.city,
              ),
              CustomTextField(
                labText: "Aera",
                controller: checkoutProvider.aera,
              ),
              CustomTextField(
                labText: "Pass Code",
                controller: checkoutProvider.pinCode,
              ),
              InkWell(
                onTap: () async {
                  final coordinates = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CustomGoogleMap(),
                    ),
                  );
                  if (coordinates != null) {
                    checkoutProvider.setLocation(
                        coordinates!["lat"], coordinates!["lng"]);
                  } else {
                    checkoutProvider.setLocation(null, null);
                  }
                },
                child: Container(
                  height: 47,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(checkoutProvider.locationCoordinates),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text(
                  "Address Type*",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              RadioListTile(
                value: AddressTypes.Home,
                groupValue: myType,
                title: Text("Home"),
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                secondary: Icon(
                  Icons.home,
                  color: primaryColor,
                ),
              ),
              RadioListTile(
                value: AddressTypes.Work,
                groupValue: myType,
                title: Text("Work"),
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                secondary: Icon(
                  Icons.work,
                  color: primaryColor,
                ),
              ),
              RadioListTile(
                value: AddressTypes.Other,
                groupValue: myType,
                title: Text("Other"),
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                secondary: Icon(
                  Icons.devices_other,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
