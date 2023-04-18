import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/news/news_view.dart';
import 'package:flutter_base/src/model/news_model.dart';
import 'package:intl/intl.dart';
import 'package:search_page/search_page.dart';
import '../../services/helpers.dart';
import '../../widgets/card/news_card.dart';

class SearchNews extends StatelessWidget {
  const SearchNews({
    super.key,
    required this.mainContext,
    required this.newsList,
    required this.child,
  });
  final BuildContext mainContext;
  final List<NewsModel?> newsList;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: () => showSearch(
          context: mainContext,
          delegate: SearchPage(
            barTheme: Theme.of(context).brightness == Brightness.dark
                ? ThemeData(
                    inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: Colors.white,
                          displayColor: Colors.white,
                        ),
                    scaffoldBackgroundColor: CustomColor.neutral1,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: CustomColor.neutral1,
                    ),
                  )
                : ThemeData(
                    inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: CustomColor.neutral1,
                          displayColor: CustomColor.neutral1,
                        ),
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      iconTheme:
                          IconThemeData(color: CupertinoColors.systemGrey),
                    ),
                  ),
            onQueryUpdate: print,
            items: newsList,
            searchLabel: 'Search news',
            suggestion: const Center(
              child: Text('Type news title'),
            ),
            failure: const Center(
              child: Text('No news found :('),
            ),
            filter: (news) => [
              news!.title,
              DateFormat('dd/MM/yyyy').format(news.createdAt),
              news.author!.name,
              news.author!.email,
            ],
            builder: (news) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: newsCard(
                context: context,
                imageURL: news!.imgURL,
                title: news.title,
                likeCount: news.likeCount,
                date: news.createdAt,
                onTap: () => Navigator.of(mainContext).push(
                  MaterialPageRoute(
                    builder: (context) => NewsView(
                      mainContext: mainContext,
                      news: news,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
