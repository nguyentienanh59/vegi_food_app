import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/review_cart_provider.dart';

class Count extends StatefulWidget {
  String? productName;
  String? productImage;
  String? productId;
  num? productPrice;
  String? productUnit;
  final int productQuantity;

  Count({
    this.productUnit,
    this.productName,
    this.productImage,
    this.productId,
    this.productPrice,
    required this.productQuantity,
  });

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAddAndQuatity();
  }

  getAddAndQuatity() {
    // final items = Provider.of<ReviewCartProvider>(context, listen: true)
    //     .reviewCartDataList;
    // for (var item in items) {
    //   if (item.cartId == widget.productId) {
    //     setState(() {
    //       isTrue = true;
    //       count = item.cartQuantity!;
    //     });
    //   }
    // }

    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  if (this.mounted)
                    {
                      setState((() {
                        count = value.get("cartQuantity");
                        isTrue = value.get("isAdd");
                      }))
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuatity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
      height: 30,
      width: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: isTrue == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });

                      reviewCartProvider.reviewCartDataDelete(widget.productId);
                    }
                    if (count > 1) {
                      setState(() {
                        count--;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                      );
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    size: 15,
                    color: Color(0xffd0b84c),
                  ),
                ),
                Text(
                  "$count",
                  style: TextStyle(
                    color: Color(0xffd0b84c),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if(count>= widget.productQuantity){
                      _showAlertDialog();
                      return;
                    }
                    setState(() {
                      count++;
                    });
                    reviewCartProvider.updateReviewCartData(
                      cartId: widget.productId,
                      cartImage: widget.productImage,
                      cartName: widget.productName,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                    );
                  },
                  child: Icon(
                    Icons.add,
                    size: 15,
                    color: Color(0xffd0b84c),
                  ),
                )
              ],
            )
          : Center(
              child: InkWell(
                onTap: () {
                  //neu luong san pham be hon hoac bang 0 thi se hien dialog
                  if (widget.productQuantity <= 0) {
                    _showAlertDialog();
                    return;
                  }
                  setState(() {
                    isTrue = true;
                  });

                  reviewCartProvider.addReviewCartData(
                    cartId: widget.productId,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                    cartQuantity: count,
                    cartUnit: [
                      widget.productUnit!,
                    ],
                  );
                },
                child: Text(
                  "ADD",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
    );
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
            title: Text(
              'ALERT',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            content: Text(
              'Not enough quantity',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          );
        });
  }
}
