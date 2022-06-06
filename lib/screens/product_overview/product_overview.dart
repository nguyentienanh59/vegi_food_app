import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/wish_list_provider.dart';
import 'package:vegi_food_app/screens/review_cart/review_cart.dart';
import 'package:vegi_food_app/widgets/count.dart';

enum SinginCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  final String productName;
  final String productImage;
  final num? productPrice;
  final String? productId;
  final String? about;
  final String? productUnit;
  final int? productQuantity;

  ProductOverview({
    this.productId,
    required this.productName,
    required this.productImage,
    required this.about,
    this.productPrice,
    required this.productUnit,
    this.productQuantity,
  });
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  SinginCharacter _character = SinginCharacter.fill;

  Widget bonntonNavigatorBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(25),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 17,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool wishListBool = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(
                        () {
                          wishListBool = value.get("wishList");
                        },
                      )
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishListBool();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          children: [
            bonntonNavigatorBar(
                backgroundColor: textColor,
                color: Colors.white70,
                iconColor: Colors.grey,
                title: "Add To WishList",
                iconData: wishListBool == false
                    ? Icons.favorite_outline
                    : Icons.favorite,
                onTap: () {
                  setState(() {
                    wishListBool = !wishListBool;
                  });
                  if (wishListBool == true) {
                    wishListProvider.addWishListData(
                      wishListId: widget.productId,
                      wishListImage: widget.productImage,
                      wishListName: widget.productName,
                      wishListPrice: widget.productPrice,
                      wishListQuantity: 1,
                      wishListUnit: [widget.productUnit],
                      about: widget.about,
                    );
                  } else {
                    wishListProvider.deleteWishList(widget.productId);
                  }
                }),
            bonntonNavigatorBar(
                backgroundColor: primaryColor,
                color: textColor,
                iconColor: textColor,
                title: "Go To Cart",
                iconData: Icons.shop_outlined,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReviewCart()));
                }),
          ],
        ),
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: textColor),
          title: Text(
            "Product Overview",
            style: TextStyle(color: textColor),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.productName),
                    subtitle: Text("${widget.productUnit}"),
                  ),
                  Container(
                    height: 220,
                    padding: EdgeInsets.all(20),
                    child: Image.network(widget.productImage),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      "Available Options",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              value: SinginCharacter.fill,
                              groupValue: _character,
                              activeColor: Colors.green[700],
                              onChanged: (SinginCharacter? value) {
                                setState(() {
                                  _character = value!;
                                });
                              },
                            )
                          ],
                        ),
                        Text("\$${widget.productPrice}"),
                        Count(
                          productId: widget.productId,
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                          productUnit: widget.productUnit,
                          productQuantity: widget.productQuantity??0,
                        ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 30,
                        //     vertical: 10,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(30),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.add,
                        //         size: 17,
                        //         color: primaryColor,
                        //       ),
                        //       Text(
                        //         "ADD",
                        //         style: TextStyle(color: primaryColor),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About this product",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.about ?? "No description found",
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
