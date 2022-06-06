import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/review_cart_provider.dart';
import 'package:vegi_food_app/screens/product_overview/product_overview.dart';
import 'package:vegi_food_app/widgets/count.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchItem extends StatefulWidget {
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
  SearchItem({
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
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
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
                          productQuantity: widget.productQuantity,
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
                              onTap: () {},
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
                                  widget.productUnit!.first.toString(),
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
