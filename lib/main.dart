import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/auth/sign_in.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/screens/all_product/single_product/provider/single_product_provider.dart';
import 'package:vegi_food_app/screens/all_purchased/provider/all_purchased_provider.dart';
import 'package:vegi_food_app/screens/all_user/provider/all_user_provider.dart';
import 'package:vegi_food_app/providers/check_out_provider.dart';
import 'package:vegi_food_app/providers/product_provider.dart';
import 'package:vegi_food_app/providers/review_cart_provider.dart';
import 'package:vegi_food_app/providers/statistic_provider.dart';
import 'package:vegi_food_app/providers/user_provider.dart';
import 'package:vegi_food_app/providers/wish_list_provider.dart';
import 'package:vegi_food_app/screens/all_product/provider/all_product_provider.dart';
import 'package:vegi_food_app/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider()
            ..getFreshProductDataList
            ..getHerbsProductDataList
            ..getRootProductDataList,
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider()..getRivewCartData(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider<StatisticProvider>(
          create: (context) => StatisticProvider(),
        ),
        ChangeNotifierProvider<AllUserProvider>(
            create: (context) => AllUserProvider()..getAllUser()),
        ChangeNotifierProvider<AllProductProvider>(
            create: (context) => AllProductProvider()),
        ChangeNotifierProvider<SingleProductProvider>(
            create: (context) => SingleProductProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapShot) {
            // if (snapShot.hasData) {
            //   return HomeScreen();
            // }
            return SignIn();
          },
        ),
      ),
    );
  }
}
