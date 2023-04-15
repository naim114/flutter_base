import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/news/news_view.dart';

import '../../model/news_model.dart';
import '../../widgets/card/news_card.dart';

Widget latestNews({
  required BuildContext context,
  required BuildContext mainContext,
  required List<NewsModel?> newsList,
}) =>
    Column(
      children: List.generate(newsList.length, (index) {
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
            likeCount: news.likeCount,
            onTap: () => Navigator.of(mainContext).push(MaterialPageRoute(
                builder: (context) => NewsView(
                      mainContext: mainContext,
                      news: news,
                    ))),
          ),
        );
      }),
    );
