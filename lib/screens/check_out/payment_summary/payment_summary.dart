import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/delivery_address_model.dart';
import 'package:vegi_food_app/providers/review_cart_provider.dart';
import 'package:vegi_food_app/screens/check_out/payment_summary/my_google_pay.dart';
import 'package:vegi_food_app/screens/check_out/payment_summary/order_item.dart';
import 'package:vegi_food_app/screens/home/home_screen.dart';
import 'package:vegi_food_app/screens/success_screen.dart';

class PaymentSummary extends StatefulWidget {
  const PaymentSummary({
    Key? key,
    required this.addressModel,
  }) : super(key: key);

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
  final DeliveryAddressModel addressModel;
}

enum OrderTypes {
  home,
  onlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = OrderTypes.home;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getRivewCartData();

    double discout = 30;

    double totalPrice = reviewCartProvider.getTotalPrice();
    double discoutVaule = (totalPrice * discout) / 100;
    double total = totalPrice - discoutVaule;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Payment Summary",
            style: TextStyle(fontSize: 18, color: textColor),
          ),
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: textColor),
        ),
        bottomNavigationBar: ListTile(
          title: const Text("Total Amount"),
          subtitle: Text(
            "\$${total + 2.5 + 2}",
            style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          trailing: SizedBox(
            width: 160,
            child: myType == OrderTypes.home
                ? MaterialButton(
                    onPressed: () async {
                      if (myType == OrderTypes.onlinePayment) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => MyGooglePay(
                                  total: total,
                                )),
                          ),
                        );
                      } else {
                        await reviewCartProvider.finishPayment();
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SuccessScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Pleace Order",
                      style: TextStyle(color: textColor),
                    ),
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  )
                : GooglePayButton(
                    style: GooglePayButtonStyle.black,
                    onPaymentResult: (result) async {
                      await reviewCartProvider.finishPayment();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SuccessScreen(),
                        ),
                      );
                    },
                    onError: (error) {},
                    paymentConfigurationAsset:
                        "sample_payment_configuration.json",
                    paymentItems: [
                      PaymentItem(
                        amount: "$total",
                        status: PaymentItemStatus.final_price,
                        label: "Total",
                      )
                    ],
                  ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              final addressModel = widget.addressModel;
              return Column(
                children: [
                  ListTile(
                    title: Text(
                        "${addressModel.firstName}  ${addressModel.lastName}"),
                    // TODO: add address
                    subtitle: Text(
                      "${addressModel.mobileNo}, ${addressModel.aera}, ${addressModel.landMark}, ${addressModel.street}, ${addressModel.city}, ${addressModel.soiety}, ${addressModel.pinCode} ",
                    ),
                  ),
                  const Divider(),
                  ExpansionTile(
                    children: reviewCartProvider.getReviewCartDataList.map((e) {
                      return OrderItem(
                        e: e,
                      );
                    }).toList(),
                    title: Text(
                        "Order Item ${reviewCartProvider.getReviewCartDataList.length}"),
                  ),
                  const Divider(),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: const Text(
                      "Sub Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "\$$totalPrice",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Shipping Charge ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: const Text(
                      "\$2.5",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Company Discount ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: const Text(
                      "\$2",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Discout ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      "\$$discoutVaule",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: Text("Payment Options"),
                  ),
                  RadioListTile(
                    value: OrderTypes.home,
                    groupValue: myType,
                    title: const Text("Home"),
                    onChanged: (OrderTypes? value) {
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
                    value: OrderTypes.onlinePayment,
                    groupValue: myType,
                    title: const Text("Online Payment"),
                    onChanged: (OrderTypes? value) {
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(
                      Icons.work,
                      color: primaryColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
