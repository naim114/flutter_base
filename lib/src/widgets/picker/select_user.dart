import 'package:flutter/material.dart';
import 'package:flutter_base/src/widgets/appbar/appbar_confirm_cancel.dart';

class UsersPicker extends StatefulWidget {
  const UsersPicker({super.key});

  @override
  State<UsersPicker> createState() => _UsersPickerState();
}

class _UsersPickerState extends State<UsersPicker> {
  List<dynamic> data = [
    {
      "Email": "admin@email.com",
      "Role": "Admin",
    },
    {
      "Email": "user@email.com",
      "Role": "User",
    },
  ];

  List<dynamic> filteredData = [];

  List<dynamic> selected = [];

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
      appBar: appBarConfirmCancel(
        onCancel: () => Navigator.pop(context),
        onConfirm: () {},
        context: context,
        title: "Select Users",
      ),
      body: ListView(
        children: [
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
                  ],
                  onSelectAll: (isSelectedAll) {
                    setState(() {
                      if (isSelectedAll == true) {
                        for (var item in data) {
                          selected.add(item['Email']);
                        }
                      } else {
                        selected = [];
                      }
                    });
                  },
                  rows: List.generate(filteredData.length, (index) {
                    final item = filteredData[index];
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // All rows will have the same selected color.
                        if (states.contains(MaterialState.selected)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.08);
                        }
                        // Even rows will have a grey color.
                        if (index.isEven) {
                          return Colors.grey.withOpacity(0.3);
                        }
                        return null; // Use default value for other states and odd rows.
                      }),
                      cells: [
                        DataCell(Text(item['Role'])),
                        DataCell(Text(item['Email'])),
                      ],
                      selected: selected.contains(item['Email']),
                      onSelectChanged: (bool? isSelected) {
                        if (isSelected != null) {
                          setState(() {
                            isSelected
                                ? selected.add(item['Email'])
                                : selected.remove(item['Email']);
                          });
                        }
                      },
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
