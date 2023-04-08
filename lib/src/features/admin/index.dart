import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/admin/news/index.dart';
import 'package:flutter_base/src/features/admin/notification/index.dart';
import 'package:flutter_base/src/features/admin/users/builder.dart';

import '../../services/helpers.dart';
import '../../widgets/list_tile/list_tile_icon.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

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
          "Admin Panel",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: ListView(
        children: [
          listTileIcon(
            context: context,
            icon: CupertinoIcons.group_solid,
            title: "Users",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AdminPanelUsersBuilder(),
              ),
            ),
          ),
          listTileIcon(
            context: context,
            icon: Icons.notifications,
            title: "Notification",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AdminPanelNotification(),
              ),
            ),
          ),
          listTileIcon(
            context: context,
            icon: Icons.newspaper,
            title: "News",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AdminPanelNews(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
