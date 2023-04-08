import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/admin/users/edit.dart';
import 'package:flutter_base/src/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/user_model.dart';
import '../../../services/helpers.dart';

class AdminPanelUsers extends StatefulWidget {
  final List<UserModel> userList;
  final UserModel currentUser;
  const AdminPanelUsers(
      {super.key, required this.userList, required this.currentUser});

  @override
  State<AdminPanelUsers> createState() => _AdminPanelUsersState();
}

class _AdminPanelUsersState extends State<AdminPanelUsers> {
  List<UserModel> filteredData = [];

  final searchController = TextEditingController();

  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  void initState() {
    filteredData = widget.userList;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? widget.userList
          : widget.userList
              .where((user) =>
                  user.email.toLowerCase().contains(text.toLowerCase()) ||
                  user.role!.name.toLowerCase().contains(text.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColor.neutral2,
          ),
        ),
        title: Text(
          "Manage Users",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            child: Text(
              'View all user here. Search for user by typing user email or role. Edit or Disable users by clicking on the actions button.',
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchTextChanged,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DataTable(
                  sortColumnIndex: _currentSortColumn,
                  sortAscending: _isAscending,
                  columns: <DataColumn>[
                    const DataColumn(
                      label: Text(''),
                    ),
                    DataColumn(
                      label: const Text('Role'),
                      onSort: (columnIndex, _) {
                        setState(() {
                          _currentSortColumn = columnIndex;
                          if (_isAscending == true) {
                            _isAscending = false;
                            widget.userList.sort((userA, userB) =>
                                userA.role!.name.compareTo(userB.role!.name));
                          } else {
                            _isAscending = true;
                            widget.userList.sort((userA, userB) =>
                                userB.role!.name.compareTo(userA.role!.name));
                          }
                        });
                      },
                    ),
                    DataColumn(
                      label: const Text('Email'),
                      onSort: (columnIndex, _) {
                        setState(() {
                          _currentSortColumn = columnIndex;
                          if (_isAscending == true) {
                            _isAscending = false;
                            widget.userList.sort((userA, userB) =>
                                userA.email.compareTo(userB.email));
                          } else {
                            _isAscending = true;
                            widget.userList.sort((userA, userB) =>
                                userB.email.compareTo(userA.email));
                          }
                        });
                      },
                    ),
                    DataColumn(
                      label: const Text('Status'),
                      onSort: (columnIndex, _) {
                        setState(() {
                          _currentSortColumn = columnIndex;
                          if (_isAscending == true) {
                            _isAscending = false;
                            widget.userList.sort((userA, userB) =>
                                userA.disableAt!.compareTo(userB.disableAt!));
                          } else {
                            _isAscending = true;
                            widget.userList.sort((userA, userB) =>
                                userB.disableAt!.compareTo(userA.disableAt!));
                          }
                        });
                      },
                    ),
                    const DataColumn(
                      label: Text('Actions'),
                    ),
                  ],
                  rows: List.generate(filteredData.length, (index) {
                    final user = filteredData[index];
                    return DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.055,
                            child: user.avatarURL == null
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.055,
                                    width: MediaQuery.of(context).size.height *
                                        0.055,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/default-profile-picture.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: user.avatarURL!,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.055,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.055,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: CupertinoColors.systemGrey,
                                      highlightColor:
                                          CupertinoColors.systemGrey2,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.055,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.055,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) {
                                      print("Avatar Error: $error");
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.055,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.055,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/default-profile-picture.png'),
                                              fit: BoxFit.cover),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        DataCell(Text(user.role!.displayName)),
                        DataCell(Text(user.email)),
                        DataCell(Text(
                            user.disableAt == null ? "Active" : "Disabled")),
                        DataCell(
                          Row(
                            children: [
                              // Edit
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditUser(
                                      user: user,
                                      currentUser: widget.currentUser,
                                    ),
                                  ),
                                ),
                              ),
                              user.disableAt == null
                                  // Disable
                                  ? IconButton(
                                      icon: const Icon(Icons.person_remove),
                                      onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Disable User?'),
                                          content: const Text(
                                              'Are you sure you want to disable this user? Select OK to confirm.'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: CupertinoColors
                                                      .systemGrey,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                final result =
                                                    await UserServices()
                                                        .disableUser(
                                                            user: user);

                                                if (result == true) {
                                                  print("User disabled");
                                                  Fluttertoast.showToast(
                                                      msg: "User disabled");
                                                }

                                                Navigator.pop(context);
                                              },
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
                                    )
                                  // Enable
                                  : IconButton(
                                      icon: const Icon(Icons.person_add),
                                      onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Enable User?'),
                                          content: const Text(
                                              'Are you sure you want to enable this user? Select OK to confirm.'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: CupertinoColors
                                                      .systemGrey,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                final result =
                                                    await UserServices()
                                                        .enableUser(user: user);

                                                if (result == true) {
                                                  print("User enabled");
                                                  Fluttertoast.showToast(
                                                      msg: "User enabled");
                                                }

                                                Navigator.pop(context);
                                              },
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
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
