import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/features/news/news_section.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:provider/provider.dart';
import '../../model/app_settings_model.dart';
import '../../model/news_model.dart';
import '../../model/user_model.dart';

class News extends StatefulWidget {
  const News({
    super.key,
    required this.mainContext,
    required this.user,
  });
  final BuildContext mainContext;
  final UserModel? user;

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<List<NewsModel>> allList = [
    [], // fetchedStarredNews
    [], // fetchedPopularNews
    [], // fetchedLatestNews
  ];
  bool loading = true;

  Future<void> _refreshData() async {
    try {
      final List<NewsModel> fetchedStarredNews = (await NewsService().getAllBy(
        fieldName: 'starred',
        desc: true,
        limit: 5,
      ))
          .whereType<NewsModel>()
          .toList();
      final List<NewsModel> fetchedPopularNews = (await NewsService().getAllBy(
        fieldName: 'likeCount',
        desc: true,
        limit: 5,
      ))
          .whereType<NewsModel>()
          .toList();
      final List<NewsModel> fetchedLatestNews = (await NewsService().getAllBy(
        fieldName: 'createdAt',
        desc: true,
        limit: 5,
      ))
          .whereType<NewsModel>()
          .toList();

      setState(() {
        loading = false;
        allList = [fetchedStarredNews, fetchedPopularNews, fetchedLatestNews];
      });

      // Trigger a refresh of the RefreshIndicator widget
      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Error Get All Type of News:  ${e.toString()}");
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
    final appSettings = Provider.of<AppSettingsModel?>(context);

    return (appSettings == null && widget.user == null) || loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshData,
            child: Builder(
              builder: (context) {
                final List<NewsModel?> starredNewsList = allList[0];
                final List<NewsModel?> popularNewsList = allList[1];
                final List<NewsModel?> latestNewsList = allList[2];

                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () async {
                          showDialog(
                            context: widget.mainContext,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          await NewsService().searchNews(
                              context: widget.mainContext, user: widget.user!);

                          if (context.mounted) {
                            Navigator.of(widget.mainContext,
                                    rootNavigator: true)
                                .pop();
                          }
                        },
                        icon: const Icon(Icons.search),
                      )
                    ],
                    title: CachedNetworkImage(
                      imageUrl: appSettings!.logoFaviconURL,
                      fit: BoxFit.contain,
                      height: 30,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/default_logo_favicon.png',
                        fit: BoxFit.contain,
                        height: 30,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/default_logo_favicon.png',
                        fit: BoxFit.contain,
                        height: 30,
                      ),
                    ),
                  ),
                  body: ListView(
                    children: [
                      const SizedBox(height: 5),
                      starredNewsList.isEmpty
                          ? const SizedBox()
                          : newsSection(
                              context: context,
                              mainContext: widget.mainContext,
                              newsList: starredNewsList,
                              user: widget.user!,
                              title: 'More News',
                            ),
                      const SizedBox(height: 5),
                      // Popular News Cards
                      popularNewsList.isEmpty
                          ? const SizedBox()
                          : newsSection(
                              context: context,
                              mainContext: widget.mainContext,
                              newsList: popularNewsList,
                              user: widget.user!,
                              title: 'Popular News',
                            ),
                      const SizedBox(height: 5),
                      // Latest News Cards
                      latestNewsList.isEmpty
                          ? const SizedBox()
                          : newsSection(
                              context: context,
                              mainContext: widget.mainContext,
                              newsList: latestNewsList,
                              user: widget.user!,
                              title: 'Latest News',
                            ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
