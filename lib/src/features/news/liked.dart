import 'package:flutter/material.dart';
import 'package:news_app/src/features/news/news_view.dart';
import 'package:news_app/src/model/user_model.dart';

import '../../model/news_model.dart';
import '../../services/helpers.dart';
import '../../services/news_services.dart';
import '../../widgets/card/news_card.dart';

class LikedNews extends StatefulWidget {
  final UserModel user;

  const LikedNews({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<LikedNews> createState() => _LikedNewsState();
}

class _LikedNewsState extends State<LikedNews> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<NewsModel?> newsList = [];

  Future<void> _refreshData() async {
    try {
      final List<NewsModel?> fetch =
          await NewsService().getAllLikedBy(user: widget.user);

      setState(() {
        newsList = fetch;
      });
    } catch (e) {
      print("Error Get Liked News: ${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
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
          "Liked News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            NewsModel news = newsList[index]!;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 3,
              ),
              child: newsCard(
                context: context,
                imageURL: news.imgURL,
                title: news.title,
                date: news.createdAt,
                likeCount: news.likedBy == null ? 0 : news.likedBy!.length,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewsView(
                      mainContext: context,
                      news: news,
                      user: widget.user,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
