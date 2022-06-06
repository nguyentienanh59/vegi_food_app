import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/delivery_address_model.dart';
import 'package:vegi_food_app/providers/check_out_provider.dart';
import 'package:vegi_food_app/screens/check_out/add_delivery_adress/add_delivery_address.dart';
import 'package:vegi_food_app/screens/check_out/delivery_deltails/single_delivery_item.dart';

class MyDeliveryAddress extends StatelessWidget {
  const MyDeliveryAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          "My Delivery Address",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliverAdress(),
            ),
          );
        },
      ),
      body: StreamBuilder<DeliveryAddressModel?>(
          stream: Provider.of<CheckoutProvider>(
            context,
            listen: false,
          ).deliveryAddressStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Center(child: Text("NO DATA")),
              );
            }
            final data = snapshot.data!;

            return ListView(
              children: [
                ListTile(
                  title: const Text("Deliver To"),
                  leading: Image.asset(
                    "assets/location.png",
                    height: 35,
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                SingleDeliveryItem(
                  address:
                      "Aera: ${data.aera}, LandMark: ${data.landMark}, Street: ${data.street}, City: ${data.city}, Society: ${data.soiety}, Passcode: ${data.pinCode},",
                  title: "${data.firstName} ${data.lastName}",
                  number: data.mobileNo,
                  addressType: data.addressType == "AddressTypes.Other"
                      ? "Other"
                      : data.addressType == "AddressTypes.Home"
                          ? "Home"
                          : "Work",
                )
              ],
            );
          }),
    );
  }
}
