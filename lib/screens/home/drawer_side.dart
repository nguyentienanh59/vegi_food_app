import 'package:flutter/material.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/user_provider.dart';
import 'package:vegi_food_app/screens/home/home_screen.dart';
import 'package:vegi_food_app/screens/my_profile/my_profile.dart';
import 'package:vegi_food_app/screens/statistic/statistic.dart';
import 'package:vegi_food_app/screens/wishList/wish_list.dart';

import '../review_cart/review_cart.dart';

class DrawerSide extends StatefulWidget {
  UserProvider? userProvider;
  DrawerSide({this.userProvider});

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = widget.userProvider?.currenUserData;
    return Drawer(
      child: Container(
        width: 100,
        color: primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white54,
                      radius: 43,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        backgroundImage: NetworkImage(userData!.userImage),
                        radius: 40,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userData.userName,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(userData.userEmail)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            listTile(
                icon: Icons.home_outlined,
                title: 'Home',
                onTap: () {
                  Navigator.of(context).pop();
                }),
            listTile(
              icon: Icons.shop_outlined,
              title: 'Review Cart',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
            ),
            listTile(
                icon: Icons.person_outline,
                title: 'My Profile',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyProfile(
                        userProvider: widget.userProvider,
                      ),
                    ),
                  );
                }),
            listTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {}),
            listTile(
                icon: Icons.star_outline,
                title: 'Rating & Review',
                onTap: () {}),
            listTile(
                icon: Icons.favorite_outline,
                title: 'Wish List',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WishList(),
                    ),
                  );
                }),
            listTile(
                icon: Icons.copy_outlined,
                title: 'Ralse a Complaint',
                onTap: () {}),
            listTile(
                icon: Icons.format_quote_outlined, title: 'FAQs', onTap: () {}),
            Container(
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Support',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Call us:    ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('0345626987')
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            'Mail us:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('nguyentienanh@gmail.com'),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
