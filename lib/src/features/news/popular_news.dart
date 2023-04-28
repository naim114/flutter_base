import 'package:flutter/material.dart';

import '../../model/news_model.dart';
import '../../model/user_model.dart';
import '../../widgets/card/news_card.dart';
import 'news_view.dart';

Widget popularNews({
  required BuildContext context,
  required BuildContext mainContext,
  required List<NewsModel?> newsList,
  required UserModel user,
}) =>
    Column(
      children: List.generate(
        newsList.length,
        (index) {
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
              onTap: () => Navigator.of(mainContext).push(
                MaterialPageRoute(
                  builder: (context) => NewsView(
                    mainContext: mainContext,
                    news: news,
                    user: user,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
