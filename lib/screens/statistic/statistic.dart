import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/models/product_model.dart';
import 'package:vegi_food_app/providers/statistic_provider.dart';
import 'package:vegi_food_app/screens/home/singal_product.dart';
import 'package:vegi_food_app/screens/product_overview/product_overview.dart';
import 'package:vegi_food_app/screens/review_cart/review_cart.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late StatisticProvider _provider;
  bool isLoading = true;

  @override
  void initState() {
    _provider = Provider.of<StatisticProvider>(context, listen: false);
    super.initState();
    getDatas();
  }

  void getDatas() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      // drawer: DrawerSide(
      //   userProvider: userProvider,
      // ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Statistic',
            style: TextStyle(color: Colors.black, fontSize: 17)),
        backgroundColor: const Color(0xffd7b738),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red)),
                      title: Text('Total Revenue:'),
                      trailing: StreamBuilder<num>(
                          stream: _provider.getTotalRevenue('HerbsProduct'),
                          builder: (context, snapshotHerb) {
                            return StreamBuilder<num>(
                                stream:
                                    _provider.getTotalRevenue('RootProduct'),
                                builder: (context, snapshotRoot) {
                                  return StreamBuilder<num>(
                                      stream: _provider
                                          .getTotalRevenue('FreshProduct'),
                                      builder: (context, snapshotFresh) {
                                        num total = snapshotHerb.data! +
                                            snapshotFresh.data! +
                                            snapshotRoot.data!;
                                        return Text('${total} \$');
                                      });
                                });
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red)),
                      title: Text('Total User:'),
                      trailing: StreamBuilder<int>(
                          stream: _provider.getTotalUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Text('${snapshot.data}');
                            return Text('0');
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red)),
                      title: Text('Total Product:'),
                      trailing: StreamBuilder<List<ProductModel>>(
                        stream: _provider.herbStream(),
                        builder: (context, snapshotHerb) =>
                            StreamBuilder<List<ProductModel>>(
                                stream: _provider.freshStream(),
                                builder: (context, snapshotFresh) =>
                                    StreamBuilder<List<ProductModel>>(
                                        stream: _provider.rootStream(),
                                        builder: (context, snapshotRoot) {
                                          if (snapshotFresh.hasData &&
                                              snapshotHerb.hasData &&
                                              snapshotRoot.hasData) {
                                            var count =
                                                snapshotRoot.data!.length +
                                                    snapshotHerb.data!.length +
                                                    snapshotFresh.data!.length;
                                            return Text('${count}');
                                          }
                                          return Text('0.0');
                                        })),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red)),
                      title: Text('Herb Product Sold:'),
                      trailing: StreamBuilder<int>(
                          stream: _provider.herbsSoldNum(),
                          builder: (context, snapshotHerb) => Text(
                              '${snapshotHerb.hasData ? snapshotHerb.data : 0}')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red)),
                      title: Text('Fresh Product Sold:'),
                      trailing: StreamBuilder<int>(
                          stream: _provider.freshSoldNum(),
                          builder: (context, snapshotFresh) => Text(
                              '${snapshotFresh.hasData ? snapshotFresh.data : 0}')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red)),
                      title: Text('Root Product Sold:'),
                      trailing: StreamBuilder<int>(
                          stream: _provider.rootSoldNum(),
                          builder: (context, snapshotRoot) => Text(
                              '${snapshotRoot.hasData ? snapshotRoot.data : 0}')),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
