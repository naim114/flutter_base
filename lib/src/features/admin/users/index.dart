import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/admin/users/edit.dart';

import '../../../services/helpers.dart';

class AdminPanelUsers extends StatefulWidget {
  const AdminPanelUsers({super.key});

  @override
  State<AdminPanelUsers> createState() => _AdminPanelUsersState();
}

class _AdminPanelUsersState extends State<AdminPanelUsers> {
  List<dynamic> data = [
    {
      "Profile Picture":
          "https://img.theculturetrip.com/1000x/wp-content/uploads/2017/02/nasi-lemak.jpg",
      "Email": "admin@email.com",
      "Role": "Admin",
    },
    {
      "Profile Picture":
          "https://www.goodnewsfromindonesia.id/wp-content/uploads/images/source/bagusdr/penyu-6.jpg",
      "Email": "user@email.com",
      "Role": "User",
    },
  ];

  List<dynamic> filteredData = [];

  final searchController = TextEditingController();

  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  void initState() {
    filteredData = data;
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
          ? data
          : data
              .where((item) =>
                  item['Email'].toLowerCase().contains(text.toLowerCase()) ||
                  item['Role'].toLowerCase().contains(text.toLowerCase()))
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
              'View all user here. Search for user by typing user email or role. Edit or Delete users by clicking on the actions button.',
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
                            data.sort((itemA, itemB) =>
                                itemB['Role'].compareTo(itemA['Role']));
                          } else {
                            _isAscending = true;
                            data.sort((itemA, itemB) =>
                                itemA['Role'].compareTo(itemB['Role']));
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
                            data.sort((itemA, itemB) =>
                                itemB['Email'].compareTo(itemA['Email']));
                          } else {
                            _isAscending = true;
                            data.sort((itemA, itemB) =>
                                itemA['Email'].compareTo(itemB['Email']));
                          }
                        });
                      },
                    ),
                    const DataColumn(
                      label: Text('Actions'),
                    ),
                  ],
                  rows: List.generate(filteredData.length, (index) {
                    final item = filteredData[index];
                    return DataRow(
                      cells: [
                        DataCell(
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(item['Profile Picture']),
                          ),
                        ),
                        DataCell(Text(item['Role'])),
                        DataCell(Text(item['Email'])),
                        DataCell(
                          Row(
                            children: [
                              // Edit
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const EditUser(),
                                  ),
                                ),
                              ),
                              // Delete
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Delete User?'),
                                    content: const Text(
                                        'Are you sure you want to delete this user? Deleted data may can\'t be retrieved back. Select OK to confirm.'),
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
