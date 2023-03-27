import 'package:flutter/material.dart';

import '../../widgets/card/news_card.dart';

Widget latestNews({required BuildContext context}) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 3,
          ),
          child: newsCard(
            context: context,
            imageURL:
                'https://img.theculturetrip.com/1440x807/smart/wp-content/uploads/2017/02/nasi-lemak.jpg',
            title:
                'Small U.S. banks see record drop in deposits after SVB collapse.',
            date: DateTime.now(),
            likeCount: 20,
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
                'https://img.theculturetrip.com/1440x807/smart/wp-content/uploads/2017/02/nasi-lemak.jpg',
            title:
                'Small U.S. banks see record drop in deposits after SVB collapse.',
            date: DateTime.now(),
            likeCount: 20,
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
                'https://img.theculturetrip.com/1440x807/smart/wp-content/uploads/2017/02/nasi-lemak.jpg',
            title:
                'Small U.S. banks see record drop in deposits after SVB collapse.',
            date: DateTime.now(),
            likeCount: 20,
          ),
        ),
      ],
    );
