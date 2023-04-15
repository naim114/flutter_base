import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/news/carousel_news.dart';
import 'package:flutter_base/src/features/news/latest_news.dart';
import 'package:flutter_base/src/features/news/popular_news.dart';
import 'package:flutter_base/src/features/news/search_news.dart';
import 'package:flutter_base/src/services/news_services.dart';
import '../../model/news_model.dart';
import '../../widgets/typography/page_title_icon.dart';

class News extends StatefulWidget {
  const News({super.key, required this.mainContext});
  final BuildContext mainContext;

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<List<NewsModel?>> allList = [
    [], // fetchedAllNews
    [], // fetchedStarredNews
    [], // fetchedPopularNews
    [], // fetchedLatestNews
  ];

  Future<void> _refreshData() async {
    try {
      final List<NewsModel?> fetchedAllNews = await NewsService().getAll();
      final List<NewsModel?> fetchedStarredNews = await NewsService().getAllBy(
        fieldName: 'starred',
        desc: true,
        limit: 5,
      );
      final List<NewsModel?> fetchedPopularNews = await NewsService().getAllBy(
        fieldName: 'likeCount',
        desc: true,
        limit: 5,
      );
      final List<NewsModel?> fetchedLatestNews = await NewsService().getAllBy(
        fieldName: 'createdAt',
        desc: true,
        limit: 5,
      );

      setState(() {
        allList = [
          fetchedAllNews,
          fetchedStarredNews,
          fetchedPopularNews,
          fetchedLatestNews
        ];
      });

      // Trigger a refresh of the RefreshIndicator widget
      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Error Get All Type of News:  ${e.toString()}");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: FutureBuilder<List<List<NewsModel?>>>(
            future: Future.wait([
              NewsService().getAll(),
              NewsService().getAllBy(
                fieldName: 'starred',
                desc: true,
                limit: 5,
              ),
              NewsService().getAllBy(
                fieldName: 'likeCount',
                desc: true,
                limit: 5,
              ),
              NewsService().getAllBy(
                fieldName: 'createdAt',
                desc: true,
                limit: 5,
              ),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<NewsModel?> allNews = snapshot.data![0];
                final List<NewsModel?> starredNewsList = snapshot.data![1];
                final List<NewsModel?> popularNewsList = snapshot.data![2];
                final List<NewsModel?> latestNewsList = snapshot.data![3];

                return allNews.isEmpty ||
                        starredNewsList.isEmpty ||
                        popularNewsList.isEmpty ||
                        latestNewsList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        children: [
                          // Page Title
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
                                  title: "News",
                                  icon: const Icon(
                                    Icons.newspaper,
                                    size: 24,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Get all the latest news here.',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SearchNews(
                            mainContext: widget.mainContext,
                            newsList: allNews,
                          ),
                          // Carousel News (Starred News)
                          CarouselNews(
                            mainContext: widget.mainContext,
                            newsList: starredNewsList,
                          ),
                          // Popular News Cards
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Text(
                              "Popular News",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          popularNews(
                            context: context,
                            mainContext: widget.mainContext,
                            newsList: popularNewsList,
                          ),
                          // Latest News Cards
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Text(
                              "Latest News",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          latestNews(
                            context: context,
                            mainContext: widget.mainContext,
                            newsList: latestNewsList,
                          ),
                          const SizedBox(height: 40),
                        ],
                      );
              }
            }),
      ),
    );
  }
}
