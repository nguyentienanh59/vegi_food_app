import 'package:flutter/material.dart';
import 'package:vegi_food_app/models/review_cart_model.dart';
import 'package:vegi_food_app/screens/review_cart/review_cart.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel e;
  OrderItem({required this.e});
  bool? isTrue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.cartImage!,
        width: 60,
      ),
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              e.cartName!,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              e.cartUnit!.first,
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              "\$${e.cartPrice}",
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
      subtitle: Text(e.cartQuantity.toString()),
    );
  }
}
