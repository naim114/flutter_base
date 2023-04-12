import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/news/news_view.dart';

import '../../widgets/card/news_card.dart';

Widget popularNews({
  required BuildContext context,
  required BuildContext mainContext,
}) =>
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 3,
          ),
          child: newsCard(
            context: context,
            imageURL:
                'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
            title:
                'Small U.S. banks see record drop in deposits after SVB collapse.',
            date: DateTime.now(),
            likeCount: 20,
            onTap: () {},
            // onTap: () => Navigator.of(mainContext).push(MaterialPageRoute(
            //     builder: (context) => NewsView(mainContext: mainContext))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 3,
          ),
          child: newsCard(
            context: context,
            imageURL:
                'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
            title:
                'Small U.S. banks see record drop in deposits after SVB collapse.',
            date: DateTime.now(),
            likeCount: 20,
            onTap: () {},
            // onTap: () => Navigator.of(mainContext).push(MaterialPageRoute(
            //     builder: (context) => NewsView(mainContext: mainContext))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 3,
          ),
          child: newsCard(
            context: context,
            imageURL:
                'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
            title:
                'Small U.S. banks see record drop in deposits after SVB collapse.',
            date: DateTime.now(),
            likeCount: 20,
            onTap: () {},
            // onTap: () => Navigator.of(mainContext).push(MaterialPageRoute(
            //     builder: (context) => NewsView(mainContext: mainContext))),
          ),
        ),
      ],
    );
