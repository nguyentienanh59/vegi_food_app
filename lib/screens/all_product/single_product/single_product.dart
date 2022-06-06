import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/product_model.dart';
import 'package:vegi_food_app/screens/all_product/category.dart';
import 'package:vegi_food_app/screens/all_product/single_product/provider/single_product_provider.dart';

class SingleProduct extends StatefulWidget {
  ProductModel product;
  final Category category;

  SingleProduct({Key? key, required this.product, required this.category})
      : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  ValueNotifier<bool> _isUpdate = ValueNotifier(false);

  late TextEditingController _productNameController;

  late TextEditingController _productAboutController;

  late TextEditingController _productQuantityController;

  late TextEditingController _productPriceController;

  @override
  void initState() {
    _productNameController =
        TextEditingController(text: widget.product.productName);
    _productAboutController = TextEditingController(text: widget.product.about);
    _productPriceController =
        TextEditingController(text: widget.product.productPrice.toString());
    _productQuantityController =
        TextEditingController(text: widget.product.productQuantity.toString());
    super.initState();
  }

  Color _getColor() {
    switch (widget.category) {
      case Category.herb:
        return Colors.green;
      case Category.fresh:
        return Colors.redAccent;
      case Category.root:
        return Colors.brown.shade300;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<SingleProductProvider>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text('${widget.product.productName}'),
          actions: [
            ValueListenableBuilder<bool>(
              valueListenable: _isUpdate,
              builder: (context, value, child) => TextButton(
                  onPressed: () {
                    _isUpdate.value = !value;
                  },
                  child: Text(
                    value ? 'Cancel' : 'Update',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: _isUpdate,
          builder: (context, value, child) => value
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      maximumSize: Size(100, 50), primary: Colors.redAccent),
                  onPressed: () {

                    _provider.updateProduct(
                        category: widget.category,
                        productId: widget.product.productId!,
                        productName: _productNameController.value.text,
                        productPrice: num.parse(_productPriceController.value.text),
                        productQuantity: int.parse(_productQuantityController.value.text),
                        about: _productAboutController.value.text);
                  },
                  child: Text('OK'),
                )
              : Container(),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                widget.product.productImage,
                height: _screenWidth * 0.45,
                width: _screenWidth * 0.45,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Product Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isUpdate,
              builder: (context, value, child) => TextField(
                controller: _productNameController,
                enabled: value,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Product Price',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ValueListenableBuilder<bool>(
              valueListenable: _isUpdate,
              builder: (context, value, child) => TextField(
                keyboardType: TextInputType.number,
                controller: _productPriceController,
                enabled: value,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Product Quantity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ValueListenableBuilder<bool>(
              valueListenable: _isUpdate,
              builder: (context, value, child) => TextField(
                keyboardType: TextInputType.number,
                controller: _productQuantityController,
                enabled: value,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('About',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ValueListenableBuilder<bool>(
              valueListenable: _isUpdate,
              builder: (context, value, child) => TextField(
                maxLines: null,
                controller: _productAboutController,
                enabled: value,
              ),
            ),
          ],
        ));
  }
}
