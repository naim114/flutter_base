import 'package:flutter/material.dart';
import '../../../services/helpers.dart';
import '../../../widgets/list_tile/list_tile_activity.dart';

class UserActivity extends StatelessWidget {
  const UserActivity({super.key});

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
          "User Activity",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: ListView(
        children: [
          // listTileActivity(
          //       context: context,
          //       activity: list.elementAt(index),
          //       includeNetworkInfo: true,
          //     );
        ],
      ),
    );
  }
}
