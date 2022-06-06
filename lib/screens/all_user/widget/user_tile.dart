import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/models/user_model.dart';
import 'package:vegi_food_app/screens/all_user/provider/all_user_provider.dart';

class UserTile extends StatelessWidget {
  final UserModel user;

  UserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AllUserProvider>(context);
    bool _isCurrentUser() {
      if (user.userUid == FirebaseAuth.instance.currentUser!.uid) return true;
      return false;
    }

    void _handleDetailButton() async {
      _provider.deleteUser(user.userUid);
    }

    return ExpansionTile(
      expandedAlignment: Alignment.center,
      children: [
        SizedBox(height: 10,),
        Text.rich(
          TextSpan(
              text: 'user\'s uid: ',
              style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                    text: '${user.userUid}',
                    style: TextStyle(color: Colors.teal, fontSize: 15,fontWeight: FontWeight.normal))
              ]),
        ),
        Text.rich(
          TextSpan(
              text: 'user\'s email: ',
              style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                    text: '${user.userEmail}',
                    style: TextStyle(color: Colors.teal, fontSize: 15,fontWeight: FontWeight.normal))
              ]),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.red,
              textStyle: TextStyle(color: Colors.white, fontSize: 12),
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          onPressed: _isCurrentUser() ? null : () => _handleDetailButton(),
          child: Text(
            'Delete',
          ),
        ),
      ],
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.userImage),
      ),
      title: Text(
        user.userName,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      ),

    );
  }
}
