import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/notification_model.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/services/notification_services.dart';

import '../../features/admin/notification/index.dart';
import '../../model/user_model.dart';

class NotificationBuilder extends StatelessWidget {
  final UserModel currentUser;
  final String pushTo;

  const NotificationBuilder({
    super.key,
    required this.pushTo,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotificationModel?>>(
      future: NotificationServices().getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.data != null) {
          List<NotificationModel> dataList =
              snapshot.data!.whereType<NotificationModel>().toList();

          if (pushTo == 'AdminPanelNotification') {
            List<NotificationModel> uniqueNotiList = dataList
                .groupBy((noti) => noti.groupId)
                .values
                .map((group) => group.toSet().toList()[0])
                .toList();

            return AdminPanelNotification(
              currentUser: currentUser,
              notiList: uniqueNotiList,
            );
          }
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
