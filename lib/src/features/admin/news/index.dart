import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/admin/news/add.dart';
import 'package:flutter_base/src/features/admin/news/edit.dart';

import '../../../services/helpers.dart';

class AdminPanelNews extends StatefulWidget {
  const AdminPanelNews({super.key});

  @override
  State<AdminPanelNews> createState() => _AdminPanelNewsState();
}

class _AdminPanelNewsState extends State<AdminPanelNews> {
  List<dynamic> data = [
    {
      "Title": "Welcome to AppName!",
      "Created By": "Admin",
      "Created At": "10 March 2020",
    },
    {
      "Title": "New Features Available. Check out the new Update.",
      "Created By": "Admin",
      "Created At": "10 March 2020",
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
                  item['Title'].toLowerCase().contains(text.toLowerCase()))
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
          "Manage News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddNews(),
                    ),
                  ),
              icon: Icon(
                Icons.playlist_add_rounded,
                color: getColorByBackground(context),
              ))
        ],
      ),
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          child: Text(
            'View all news here. Search news by typing to the textbox. Edit or Delete news by clicking on the actions button.',
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
                  DataColumn(
                    label: const Text('Title'),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending == true) {
                          _isAscending = false;
                          data.sort((itemA, itemB) =>
                              itemB['Title'].compareTo(itemA['Title']));
                        } else {
                          _isAscending = true;
                          data.sort((itemA, itemB) =>
                              itemA['Title'].compareTo(itemB['Title']));
                        }
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('Created By'),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending == true) {
                          _isAscending = false;
                          data.sort((itemA, itemB) => itemB['Created By']
                              .compareTo(itemA['Created By']));
                        } else {
                          _isAscending = true;
                          data.sort((itemA, itemB) => itemA['Created By']
                              .compareTo(itemB['Created By']));
                        }
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('Created At'),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending == true) {
                          _isAscending = false;
                          data.sort((itemA, itemB) => itemB['Created At']
                              .compareTo(itemA['Created At']));
                        } else {
                          _isAscending = true;
                          data.sort((itemA, itemB) => itemA['Created At']
                              .compareTo(itemB['Created At']));
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
                      DataCell(Text(
                        item['Title'],
                        overflow: TextOverflow.ellipsis,
                      )),
                      DataCell(Text(item['Created By'])),
                      DataCell(Text(item['Created At'])),
                      DataCell(
                        Row(
                          children: [
                            // Edit
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditNews(),
                                ),
                              ),
                            ),
                            // Delete
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Delete News?'),
                                  content: const Text(
                                      'Are you sure you want to delete this news? Deleted data may can\'t be retrieved back. Select OK to confirm.'),
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
      ]),
    );
  }
}
