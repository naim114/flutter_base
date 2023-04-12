import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/notification_model.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/services/notification_services.dart';

import '../../features/admin/notification/index.dart';
import '../../model/user_model.dart';

class NotificationBuilder extends StatefulWidget {
  final UserModel currentUser;
  final String pushTo;

  const NotificationBuilder({
    super.key,
    required this.pushTo,
    required this.currentUser,
  });

  @override
  State<NotificationBuilder> createState() => _NotificationBuilderState();
}

class _NotificationBuilderState extends State<NotificationBuilder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<NotificationModel?> dataList = List.empty(growable: true);

  Future<void> _refreshData() async {
    try {
      // Call the asynchronous operation to fetch data
      final List<NotificationModel?> fetchedData =
          await NotificationServices().getAll();

      // Update the state with the fetched data and call setState to rebuild the UI
      setState(() {
        dataList = fetchedData;
      });

      // Trigger a refresh of the RefreshIndicator widget
      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Get All:  ${e.toString()}");
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: FutureBuilder<List<NotificationModel?>>(
        future: Future.value(dataList),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.data != null) {
            List<NotificationModel> dataList =
                snapshot.data!.whereType<NotificationModel>().toList();

            if (widget.pushTo == 'AdminPanelNotification') {
              List<NotificationModel> uniqueNotiList = dataList
                  .groupBy((noti) => noti.groupId)
                  .values
                  .map((group) => group.toSet().toList()[0])
                  .toList();

              return AdminPanelNotification(
                currentUser: widget.currentUser,
                notiList: uniqueNotiList,
                notifyRefresh: (refresh) {
                  _refreshData();
                },
              );
            }
          }

          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
