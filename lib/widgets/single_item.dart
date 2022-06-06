import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/review_cart_provider.dart';
import 'package:vegi_food_app/screens/product_overview/product_overview.dart';
import 'package:vegi_food_app/widgets/count.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingleItem extends StatefulWidget {
  bool? isBool = false;
  bool? wishList = false;
  String? productName;
  String? productImage;
  num? productPrice;
  String? productId;
  int? productQuantity;
  String? about;
  List<dynamic>? productUnit;
  Function()? onDelete;
  SingleItem({
    this.isBool,
    this.productUnit,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productId,
    this.productQuantity,
    this.onDelete,
    this.wishList,
    this.about,
  });

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late int count;
  getCount() {
    setState(() {
      count = widget.productQuantity!;
    });
  }

  ReviewCartProvider? reviewCartProvider;

  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider?.getRivewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: widget.productId,
                          productPrice: widget.productPrice,
                          productName: widget.productName!,
                          productImage: widget.productImage!,
                          about: widget.about,
                          productUnit: widget.productUnit!.first,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Image.network(widget.productImage!),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.productName!,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${widget.productPrice}\$",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      widget.isBool == false
                          ? GestureDetector(
                              onTap: () {
                                // showModalBottomSheet(
                                //     context: context,
                                //     builder: (context) {
                                //       return Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: <Widget>[
                                //           ListTile(
                                //             leading: new Icon(Icons
                                //                 .production_quantity_limits_outlined),
                                //             title: new Text("50 gram"),
                                //             onTap: () {
                                //               Navigator.pop(context);
                                //             },
                                //           ),
                                //           ListTile(
                                //             leading: new Icon(Icons
                                //                 .production_quantity_limits_outlined),
                                //             title: new Text("100 gram"),
                                //             onTap: () {
                                //               Navigator.pop(context);
                                //             },
                                //           ),
                                //           ListTile(
                                //             leading: new Icon(Icons
                                //                 .production_quantity_limits_outlined),
                                //             title: new Text("500 gram"),
                                //             onTap: () {
                                //               Navigator.pop(context);
                                //             },
                                //           ),
                                //           ListTile(
                                //             leading: new Icon(Icons
                                //                 .production_quantity_limits_outlined),
                                //             title: new Text("1 kg"),
                                //             onTap: () {
                                //               Navigator.pop(context);
                                //             },
                                //           ),
                                //           ListTile(
                                //             title: new Text(""),
                                //             onTap: () {},
                                //           ),
                                //         ],
                                //       );
                                //     });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 25),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  widget.productUnit.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          : Text(widget.productUnit!.first.toString()),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  padding: widget.isBool == false
                      ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      : EdgeInsets.only(left: 15, right: 15),
                  child: widget.isBool == false
                      ? Count(
                          productId: widget.productId,
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                    productQuantity: widget.productQuantity??0,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: widget.onDelete,
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              widget.wishList == false
                                  ? Container(
                                      height: 25,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (count == 1) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "You reach minimum limit");
                                                } else {
                                                  setState(() {
                                                    count--;
                                                  });
                                                  reviewCartProvider
                                                      ?.updateReviewCartData(
                                                          cartImage: widget
                                                              .productImage,
                                                          cartName: widget
                                                              .productName,
                                                          cartId:
                                                              widget.productId,
                                                          cartQuantity: count,
                                                          cartPrice: widget
                                                              .productPrice);
                                                }
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              "$count",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (count < 10) {
                                                  setState(() {
                                                    count++;
                                                  });
                                                  reviewCartProvider
                                                      ?.updateReviewCartData(
                                                          cartImage: widget
                                                              .productImage,
                                                          cartName: widget
                                                              .productName,
                                                          cartId:
                                                              widget.productId,
                                                          cartQuantity: count,
                                                          cartPrice: widget
                                                              .productPrice);
                                                }
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  : Container(),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
                height: 2,
                color: Color.fromARGB(115, 36, 35, 35),
              )
      ],
    );
  }
}
