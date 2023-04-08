import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/admin/users/index.dart';
import 'package:flutter_base/src/services/user_services.dart';

import '../../../model/user_model.dart';

class AdminPanelUsersBuilder extends StatelessWidget {
  const AdminPanelUsersBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel?>>(
      future: UserServices().getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data != null) {
          List<UserModel> userList =
              snapshot.data!.whereType<UserModel>().toList();

          return AdminPanelUsers(userList: userList);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
