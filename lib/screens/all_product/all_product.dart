import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/product_model.dart';
import 'package:vegi_food_app/providers/product_provider.dart';
import 'package:vegi_food_app/screens/all_product/category.dart';
import 'package:vegi_food_app/screens/all_product/provider/all_product_provider.dart';
import 'package:vegi_food_app/screens/all_product/widget/product_tile.dart';

class AllProduct extends StatelessWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AllProductProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text('All Products'),
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Herbs',
                style: TextStyle(
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            StreamBuilder<List<ProductModel>>(
              stream: _provider.allHerbStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(!snapshot.hasData) return Center(child: Text('No data'),);
                var _list = snapshot.data!;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = _list[index];
                    return ProductTile(
                      product: data,
                      category: Category.herb,
                    );
                  },
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Fresh',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            StreamBuilder<List<ProductModel>>(
              stream: _provider.allFreshStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(!snapshot.hasData) return Center(child: Text('No data'),);
                var _list = snapshot.data!;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = _list[index];
                    return ProductTile(
                      product: data,
                      category: Category.fresh,
                    );
                  },
                );
              },
            ),
             Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Root',
                style: TextStyle(
                    color: Colors.brown.shade300,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            StreamBuilder<List<ProductModel>>(
              stream: _provider.allRootStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(!snapshot.hasData) return Center(child: Text('No data'),);
                var _list = snapshot.data!;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = _list[index];
                    return ProductTile(
                      product: data,
                      category: Category.root,
                    );
                  },
                );
              },
            ),
          ],
        ));
  }
}
