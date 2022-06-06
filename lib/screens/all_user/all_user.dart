import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/models/user_model.dart';
import 'package:vegi_food_app/screens/all_user/provider/all_user_provider.dart';
import 'package:vegi_food_app/screens/all_user/widget/user_tile.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AllUserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text('All User'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: _provider.userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: const CircularProgressIndicator(),
            );
          if (snapshot.hasError) return ErrorWidget(snapshot.error!);
          var _list = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: _list.length,
            itemBuilder: (context, index) {
              var data = _list[index];
              return UserTile(user: data);
            },
          );
        },
      ),
    );
  }
}
