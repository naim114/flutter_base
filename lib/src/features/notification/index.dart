import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/list_tile/list_tile_notification.dart';
import '../../widgets/typography/page_title_icon.dart';
import '../account/profile/index.dart';
import 'notification_view.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key, required this.mainContext});

  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 25,
              left: 25,
              right: 25,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageTitleIcon(
                  context: context,
                  title: "Notification",
                  icon: const Icon(
                    CupertinoIcons.bell_fill,
                    size: 24,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'View all your notifications. Slide notification for action.',
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          ),

          // FOREACH HERE
          listTileNotification(
            onDelete: doNothing,
            onTap: () => Navigator.of(mainContext).push(
              MaterialPageRoute(
                builder: (context) => const NotificationView(),
              ),
            ),
            unread: false,
          ),
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {}
