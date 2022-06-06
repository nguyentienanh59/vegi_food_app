import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vegi_food_app/auth/sign_in.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/user_provider.dart';
import 'package:vegi_food_app/screens/my_profile/delivery_address.dart';
import 'package:vegi_food_app/screens/purchased_history/purchased_history.dart';

class MyProfile extends StatefulWidget {
  final UserProvider? userProvider;
  const MyProfile({Key? key, this.userProvider}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Widget listTitle(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = widget.userProvider!.currenUserData;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  color: primaryColor,
                ),
                Container(
                  height: 650,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 280,
                            height: 80,
                            padding: const EdgeInsets.only(
                              left: 1,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData!.userName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(userData.userEmail),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primaryColor,
                                  child: CircleAvatar(
                                    radius: 12,
                                    child: Icon(
                                      Icons.edit,
                                      color: primaryColor,
                                    ),
                                    backgroundColor: scaffoldBackgroundColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      listTitle(
                          icon: Icons.shop_outlined,
                          title: "Purchase History",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PurchasedHostoryScreen(),
                              ),
                            );
                          }),
                      listTitle(
                          icon: Icons.location_on_outlined,
                          title: "My Delivery Address",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MyDeliveryAddress(),
                              ),
                            );
                          }),
                      listTitle(
                          icon: Icons.person_outline,
                          title: "Refer A Friends",
                          onTap: () {}),
                      listTitle(
                          icon: Icons.file_copy_outlined,
                          title: "Terms & Conditions",
                          onTap: () {}),
                      listTitle(
                          icon: Icons.policy_outlined,
                          title: "Privacy Policy",
                          onTap: () {}),
                      listTitle(
                          icon: Icons.add_chart, title: "About", onTap: () {}),
                      listTitle(
                          icon: Icons.exit_to_app_outlined,
                          title: "Log Out",
                          onTap: () async {
                            await GoogleSignIn().disconnect();
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 30),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: primaryColor,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userData.userImage),
                  radius: 45,
                  backgroundColor: scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
