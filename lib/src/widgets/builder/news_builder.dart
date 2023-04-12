import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/news_model.dart';
import 'package:flutter_base/src/services/news_services.dart';

import '../../features/admin/news/index.dart';
import '../../model/user_model.dart';

class NewsBuilder extends StatelessWidget {
  const NewsBuilder({
    super.key,
    required this.currentUser,
    required this.pushTo,
  });
  final UserModel currentUser;
  final String pushTo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel?>>(
      future: NewsService().getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.data != null) {
          List<NewsModel> dataList =
              snapshot.data!.whereType<NewsModel>().toList();

          if (pushTo == 'AdminPanelNews') {
            return AdminPanelNews(
              currentUser: currentUser,
              newsList: dataList,
            );
          }
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
