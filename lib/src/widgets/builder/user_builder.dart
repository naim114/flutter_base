import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/admin/users/index.dart';
import 'package:flutter_base/src/services/user_services.dart';

import '../../model/user_model.dart';
import '../editor/select_user.dart';

class UsersBuilder extends StatefulWidget {
  final UserModel currentUser;
  final String pushTo;
  final Function(List<UserModel> userList, BuildContext pickerContext)? onPost;

  const UsersBuilder({
    super.key,
    required this.currentUser,
    required this.pushTo,
    this.onPost,
  });

  @override
  State<UsersBuilder> createState() => _UsersBuilderState();
}

class _UsersBuilderState extends State<UsersBuilder> {
  // List<UserModel> returnUserList = List.empty();

  // void post() {
  //   print("returnUserList: $returnUserList");
  //   widget.onPost!(returnUserList);
  // }

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

          if (widget.pushTo == 'AdminPanelUsers') {
            return AdminPanelUsers(
              userList: userList,
              currentUser: widget.currentUser,
            );
          } else if (widget.pushTo == 'UsersPicker') {
            return UsersPicker(
              userList: userList,
              onPost: (selectedUserList, pickerContext) {
                print("user builder: $selectedUserList");
                widget.onPost!(selectedUserList, pickerContext);
              },
            );
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
