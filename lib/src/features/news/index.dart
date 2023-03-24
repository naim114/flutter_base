import 'package:flutter/material.dart';

import '../../widgets/typography/page_title_icon.dart';

class News extends StatelessWidget {
  const News({super.key, required this.mainContext});
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
