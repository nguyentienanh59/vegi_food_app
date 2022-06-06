import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/review_cart_model.dart';

class PurchasedHostoryScreen extends StatelessWidget {
  const PurchasedHostoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          "Purchase History",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
      body: _buldBody(),
    );
  }

  Widget _buldBody() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Center(
        child: Text("Error loading"),
      );
    }
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("purchasedHistory")
            .doc(currentUser.uid)
            .collection("YourPurchasedHistory")
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading"),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No data"),
              );
            }
            final purchasedItems = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ReviewCartModel(
                cartId: data["cartId"],
                cartImage: data["cartImage"],
                cartName: data["cartName"],
                cartPrice: data["cartPrice"],
                cartQuantity: data["cartQuantity"],
                cartUnit: data["cartUnit"],
              );
            }).toList();
            return ListView.builder(
              itemBuilder: (context, index) {
                final item = purchasedItems[index];
                // TODO:
                return ListTile(
                  isThreeLine: true,
                  minLeadingWidth: 120,
                  leading: Image.network(
                    item.cartImage!,
                    alignment: Alignment.center,
                  ),
                  title: Text(item.cartName!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.cartPrice!.toString() + "\$",
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        item.cartUnit.first,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Quantity " + item.cartQuantity.toString(),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                );
              },
              itemCount: purchasedItems.length,
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }));
  }
}
