import 'package:flutter/material.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/product_model.dart';
import 'package:vegi_food_app/widgets/search_item.dart';

enum SinginCharacter { lowToHigh, highToLow, alphabetically }

class Search extends StatefulWidget {
  final List<ProductModel>? search;
  const Search({this.search});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";
  final SinginCharacter _character = SinginCharacter.alphabetically;

  List<ProductModel> searchItem(String query) {
    final results = widget.search!
        .where((element) =>
            element.productName.toUpperCase().contains(query.toUpperCase()))
        .toSet();
    final filteredResults = <ProductModel>[];
    for (var element in results) {
      if (filteredResults
          .map((e) => e.productName)
          .contains(element.productName)) {
        continue;
      } else {
        filteredResults.add(element);
      }
    }
    return filteredResults;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Search",
          style: TextStyle(color: textColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu_rounded,
              color: textColor,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text(
              "Items",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: ((value) {
                setState(() {
                  query = value;
                });
              }),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color(0xffc2c2c2),
                filled: true,
                hintText: "Search for items in the store",
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              ..._searchItem.toList().map((data) {
                return SearchItem(
                  isBool: false,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productId: data.productId,
                  productQuantity: data.productQuantity ?? 0,
                  productUnit: data.productUnit,
                  about: data.about,
                );
              }).toList()
            ],
          ),
        ],
      ),
    );
  }
}
