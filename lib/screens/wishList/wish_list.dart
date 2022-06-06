import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/product_model.dart';
import 'package:vegi_food_app/models/review_cart_model.dart';
import 'package:vegi_food_app/providers/review_cart_provider.dart';
import 'package:vegi_food_app/providers/wish_list_provider.dart';
import 'package:vegi_food_app/widgets/single_item.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListProvider? wishListProvider;
  showAlertDialog(BuildContext context, ProductModel delete) {
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
        wishListProvider?.deleteWishList(delete.productId);
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
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your Wish List"),
          content: Text("Are you delete on wishListProduct?"),
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
    wishListProvider = Provider.of(context);
    wishListProvider?.getWishListData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Wish List",
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: StreamBuilder<List<ProductModel>>(
          stream: wishListProvider!.wishListStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error occurred, try again later"),
              );
            }
            if (snapshot.hasData) {
              final products = snapshot.data!;
              if (products.isEmpty) {
                return const Center(child: Text("No wishlist item"));
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SingleItem(
                          isBool: true,
                          productImage: product.productImage,
                          productName: product.productName,
                          productPrice: product.productPrice,
                          productId: product.productId,
                          productQuantity: product.productQuantity??0,
                          onDelete: () {
                            showAlertDialog(context, product);
                          },
                          productUnit: product.productUnit,
                          about: product.about,
                        ),
                      ],
                    );
                  },
                  itemCount: products.length,
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }),
    );
  }
}
