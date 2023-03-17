import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/account/profile/index.dart';
import 'package:flutter_base/src/features/account/security/login_activity.dart';
import 'package:flutter_base/src/features/account/security/update_email.dart';
import 'package:flutter_base/src/features/admin/user_list/user_activity.dart';
import 'package:flutter_base/src/services/helpers.dart';

import '../../account/security/update_password.dart';

class EditUser extends StatelessWidget {
  const EditUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Profile(
      bottomWidget: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text(
              "Update Email",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UpdateEmail(includeAuth: false),
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text(
              "Update Password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UpdatePassword(includeAuth: false),
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text(
              "Login Activity",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginActivity(),
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
                builder: (context) => const UserActivity(),
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
