import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/models/product_model.dart';
import 'package:vegi_food_app/screens/all_product/category.dart';
import 'package:vegi_food_app/screens/all_product/single_product/provider/single_product_provider.dart';
import 'package:vegi_food_app/screens/all_product/single_product/single_product.dart';

class ProductTile extends StatelessWidget {
  ProductModel product;
  Category category;

  ProductTile({Key? key, required this.product, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<SingleProductProvider>(context);
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              SingleProduct(product: product, category: category),
        ));
      },
      leading: Container(
        width: 50,
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Image.network(product.productImage),
      ),
      title: Text(product.productName),
      subtitle: Row(
        children: [
          Text('sold number:'),
          StreamBuilder(
              stream: _provider.getProductSold(product.productId!,category),
              builder: (context, snapshot) =>
                  Text('${snapshot.hasData ? snapshot.data : 0}'))
        ],
      ),
      trailing: Text.rich(TextSpan(
          text: 'Quantity: ',
          style: TextStyle(color: Colors.amber.shade900),
          children: [
            TextSpan(
                text: '${product.productQuantity}',
                style: TextStyle(color: Colors.lime.shade900))
          ])),
    );
  }
}
