import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/screens/all_purchased/provider/all_purchased_provider.dart';

class AllPurchased extends StatelessWidget {
  const AllPurchased({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<AllPurchasedProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text('All Purchased'),
        ),
        body: StreamBuilder<List<String>>(
          stream: _provider.getAllPurchased(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            var list = snapshot.data!;
            print(list);
            return ListView.separated(
                itemBuilder: (context, index) {
                  _provider.getUserName(list[index]).then((value) {
                    return ListTile(
                      title: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  });
                  return Text(
                    '0',
                    style: TextStyle(color: Colors.black),
                  );
                },
                separatorBuilder: (_, index) => Divider(),
                itemCount: list.length);
          },
        ));
  }
}
