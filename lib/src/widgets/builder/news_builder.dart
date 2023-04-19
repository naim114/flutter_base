import 'package:flutter/material.dart';
import 'package:news_app/src/model/news_model.dart';
import 'package:news_app/src/services/news_services.dart';

import '../../features/admin/news/index.dart';
import '../../model/user_model.dart';

class NewsBuilder extends StatefulWidget {
  const NewsBuilder({
    super.key,
    required this.currentUser,
    required this.pushTo,
  });
  final UserModel currentUser;
  final String pushTo;

  @override
  State<NewsBuilder> createState() => _NewsBuilderState();
}

class _NewsBuilderState extends State<NewsBuilder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<NewsModel?> newsList = List.empty(growable: true);

  Future<void> _refreshData() async {
    try {
      // Call the asynchronous operation to fetch data
      final List<NewsModel?> fetchedNews = await NewsService().getAll();

      // Update the state with the fetched data and call setState to rebuild the UI
      setState(() {
        newsList = fetchedNews;
      });

      // Trigger a refresh of the RefreshIndicator widget
      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Get All News:  ${e.toString()}");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: FutureBuilder<List<NewsModel?>>(
        future: NewsService().getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.data != null) {
            List<NewsModel> dataList =
                snapshot.data!.whereType<NewsModel>().toList();

            if (widget.pushTo == 'AdminPanelNews') {
              return AdminPanelNews(
                currentUser: widget.currentUser,
                newsList: dataList,
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
