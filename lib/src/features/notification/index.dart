import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../model/notification_model.dart';
import '../../services/notification_services.dart';
import '../../widgets/list_tile/list_tile_notification.dart';
import '../../widgets/typography/page_title_icon.dart';
import 'notification_view.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key, required this.mainContext});

  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel?>();

    return Scaffold(
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<NotificationModel?>>(
              future: NotificationServices().getBy('receiver', user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data != null) {
                  List<NotificationModel> dataList =
                      snapshot.data!.whereType<NotificationModel>().toList();

                  return ListView(
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
                      Column(
                        children: List.generate(dataList.length, (index) {
                          NotificationModel noti = dataList[index];
                          return listTileNotification(
                            onDelete: (context) async {
                              final result = await NotificationServices()
                                  .delete(notification: noti);

                              print("Delete: $result");
                            },
                            onTap: () async {
                              final result = await NotificationServices()
                                  .read(notification: noti);

                              print("Read: $result");

                              if (result == true) {
                                Fluttertoast.showToast(
                                    msg: "Notification Deleted");
                                Fluttertoast.showToast(
                                    msg:
                                        "Close application and reopen if no changes happen.");
                              }

                              if (context.mounted) {
                                Navigator.push(
                                  mainContext,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationView(
                                      notification: noti,
                                    ),
                                  ),
                                );
                              }
                            },
                            noti: noti,
                          );
                        }),
                      ),
                    ],
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
    );
  }
}
