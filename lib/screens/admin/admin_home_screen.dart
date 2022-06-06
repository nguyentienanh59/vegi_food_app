import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/auth/sign_in.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/screens/all_purchased/all_purchased.dart';
import 'package:vegi_food_app/screens/all_user/provider/all_user_provider.dart';
import 'package:vegi_food_app/screens/all_product/all_product.dart';
import 'package:vegi_food_app/screens/all_user/all_user.dart';
import 'package:vegi_food_app/screens/statistic/statistic.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _tileWidth = MediaQuery.of(context).size.width / 2 - 40;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text(
            'Dash board',
            style: TextStyle(color: textColor),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await GoogleSignIn().disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  );
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: textColor),
                ))
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            runSpacing: 20,
            spacing: 20,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllUser(),
                  ));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    height: _tileWidth,
                    width: _tileWidth,
                    alignment: Alignment.center,
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllProduct(),
                  ));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.amberAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    height: _tileWidth,
                    width: _tileWidth,
                    alignment: Alignment.center,
                    child: Text(
                      'Products',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StatisticScreen(),
                  ));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    height: _tileWidth,
                    width: _tileWidth,
                    alignment: Alignment.center,
                    child: Text(
                      'Statistic',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => AllPurchased(),
              //     ));
              //   },
              //   child: Card(
              //     elevation: 10,
              //     color: Colors.deepPurple,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10))),
              //     child: Container(
              //       height: _tileWidth,
              //       width: _tileWidth,
              //       alignment: Alignment.center,
              //       child: Text(
              //         'Purchased',
              //         style: TextStyle(fontSize: 20, color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
