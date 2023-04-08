import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/account/profile/index.dart';
import 'package:flutter_base/src/features/account/security/login_activity.dart';
import 'package:flutter_base/src/features/admin/users/user_activity.dart';
import 'package:flutter_base/src/services/helpers.dart';
import '../../../model/user_model.dart';

class EditUser extends StatelessWidget {
  const EditUser({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Profile(
      user: user,
      bottomWidget: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text(
              "Login Activity",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginActivity(user: user),
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text(
              "User Activity",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserActivity(user: user),
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text(
              "Ban User",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColor.danger,
              ),
            ),
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Ban User?'),
                content: const Text(
                    'Are you sure you want to ban this user? Select OK to confirm.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: CustomColor.danger,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
