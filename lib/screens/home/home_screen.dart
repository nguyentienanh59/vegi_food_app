import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/product_provider.dart';
import 'package:vegi_food_app/providers/review_cart_provider.dart';
import 'package:vegi_food_app/providers/user_provider.dart';
import 'package:vegi_food_app/screens/home/singal_product.dart';
import 'package:vegi_food_app/screens/product_overview/product_overview.dart';
import 'package:vegi_food_app/screens/review_cart/review_cart.dart';
import 'package:vegi_food_app/screens/search/search.dart';

import 'drawer_side.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  ProductProvider? productProvider;

  Widget _buildHerbsProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Herbs Seasonings'),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider!.getHerbsProductDataList,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'View all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.getHerbsProductDataList.map(
              (herbsProductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: herbsProductData.productId,
                          productPrice: herbsProductData.productPrice,
                          productName: herbsProductData.productName,
                          productImage: herbsProductData.productImage,
                          about: herbsProductData.about,
                          productUnit: herbsProductData.productUnit!.first,
                          productQuantity: herbsProductData.productQuantity,
                        ),
                      ),
                    );
                  },
                  productId: herbsProductData.productId,
                  productPrice: herbsProductData.productPrice,
                  productImage: herbsProductData.productImage,
                  productName: herbsProductData.productName,
                  productUnit: herbsProductData,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFreshProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Fresh Fruits'),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider!.getFreshProductDataList,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'View all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.getFreshProductDataList.map(
              (freshProductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: freshProductData.productId,
                          productName: freshProductData.productName,
                          productImage: freshProductData.productImage,
                          productPrice: freshProductData.productPrice,
                          about: freshProductData.about,
                          productUnit: freshProductData.productUnit!.first,
                        ),
                      ),
                    );
                  },
                  productId: freshProductData.productId,
                  productImage: freshProductData.productImage,
                  productName: freshProductData.productName,
                  productPrice: freshProductData.productPrice,
                  productUnit: freshProductData,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRootProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Root'),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider!.getRootProductDataList,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'View all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.getRootProductDataList.map(
              (rootProductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: rootProductData.productId,
                          productName: rootProductData.productName,
                          productImage: rootProductData.productImage,
                          productPrice: rootProductData.productPrice,
                          about: rootProductData.about,
                          productUnit: rootProductData.productUnit!.first,
                        ),
                      ),
                    );
                  },
                  productId: rootProductData.productId,
                  productName: rootProductData.productName,
                  productImage: rootProductData.productImage,
                  productPrice: rootProductData.productPrice,
                  productUnit: rootProductData,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    init();
    super.didChangeDependencies();
  }

  void init() async {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    await reviewCartProvider.getRivewCartData();
    await productProvider.fatchHerbsProductData();
    await productProvider.fatchFreshProductData();
    await productProvider.fatchRootProductData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(
      context,
      listen: false,
    );
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Home',
            style: TextStyle(color: Colors.black, fontSize: 17)),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xffd4d181),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      search: productProvider!.getAllProductSearch,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                size: 17,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReviewCart()));
              },
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xffd4d181),
                child: Icon(
                  Icons.shop,
                  size: 17,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xffd7b738),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListView(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/overhead-view-vegetables-black-background_23-2147915970.jpg?size=626&ext=jpg'),
                        ),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 145, bottom: 10),
                                child: Container(
                                  height: 48,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffd1ad17),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(55),
                                          bottomLeft: Radius.circular(55))),
                                  child: const Center(
                                    child: Text(
                                      'Vegi',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          shadows: [
                                            BoxShadow(
                                                color: Colors.green,
                                                blurRadius: 10,
                                                offset: Offset(3, 3))
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '30% Off',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.green.shade900,
                                          offset: const Offset(3, 3))
                                    ]),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  'On all vegetables products',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  _buildHerbsProduct(context),
                  _buildFreshProduct(context),
                  _buildRootProduct(context),
                ],
              ),
            ),
    );
  }
}
