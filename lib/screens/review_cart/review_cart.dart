import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/review_cart_model.dart';
import 'package:vegi_food_app/providers/review_cart_provider.dart';
import 'package:vegi_food_app/screens/check_out/delivery_deltails/delivery_deltails.dart';
import 'package:vegi_food_app/widgets/single_item.dart';

class ReviewCart extends StatelessWidget {
  ReviewCartProvider? reviewCartProvider;

  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider?.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("Cart Product"),
      // content: Text("Are you delete on cartProduct?"),
      actions: <Widget>[
        cancelButton,
        continueButton,
      ],
    );
    // print('call show dialog');
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cart Product"),
          content: Text("Are you delete on cartProduct?"),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider?.getRivewCartData();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ListTile(
          title: Text(
            "Total Amount",
            style: TextStyle(color: textColor, fontSize: 20),
          ),
          subtitle: Text(
            "\$ ${reviewCartProvider!.getTotalPrice()}",
            style: TextStyle(color: Colors.green[900]),
          ),
          trailing: Container(
            width: 150,
            child: MaterialButton(
              child: Text("Submit"),
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: (() {
                if (reviewCartProvider!.getReviewCartDataList.isEmpty) {
                  Fluttertoast.showToast(msg: "No Cart Data Found");
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DeliveryDetails()));
                }
              }),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: textColor),
          title: Text(
            "Review Cart",
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
        body: reviewCartProvider!.getReviewCartDataList.isEmpty
            ? const Center(
                child: Text("NO DATA"),
              )
            : ListView.builder(
                itemCount: reviewCartProvider!.getReviewCartDataList.length,
                itemBuilder: (context, index) {
                  ReviewCartModel data =
                      reviewCartProvider!.getReviewCartDataList[index];
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SingleItem(
                        isBool: true,
                        wishList: false,
                        productImage: data.cartImage,
                        productName: data.cartName,
                        productPrice: data.cartPrice,
                        productId: data.cartId,
                        productQuantity: data.cartQuantity,
                        productUnit: data.cartUnit,
                        onDelete: () {
                          showAlertDialog(context, data);
                        },
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
