import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/delivery_address_model.dart';
import 'package:vegi_food_app/providers/check_out_provider.dart';
import 'package:vegi_food_app/screens/check_out/add_delivery_adress/add_delivery_address.dart';
import 'package:vegi_food_app/screens/check_out/delivery_deltails/single_delivery_item.dart';
import 'package:vegi_food_app/screens/check_out/payment_summary/payment_summary.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Delivery Details",
            style: TextStyle(color: textColor),
          ),
          iconTheme: IconThemeData(color: textColor),
          backgroundColor: primaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDeliverAdress(),
              ),
            );
          },
        ),
        bottomNavigationBar: StreamBuilder<DeliveryAddressModel?>(
            stream: deliveryAddressProvider.deliveryAddressStream,
            builder: (context, snapshot) {
              return Container(
                height: 48,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: MaterialButton(
                  child: Text(snapshot.data == null
                      ? "Add new address"
                      : "Payment summary"),
                  onPressed: () {
                    snapshot.data == null
                        ? Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddDeliverAdress(),
                            ),
                          )
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaymentSummary(
                                addressModel: snapshot.data!,
                              ),
                            ),
                          );
                  },
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              );
            }),
        body: StreamBuilder<DeliveryAddressModel?>(
            stream: deliveryAddressProvider.deliveryAddressStream,
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
      ),
    );
  }
}
