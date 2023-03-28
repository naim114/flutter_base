import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/news/latest_news.dart';
import 'package:flutter_base/src/features/news/popular_news.dart';
import '../../widgets/carousel/image_sliders.dart';
import '../../widgets/typography/page_title_icon.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class News extends StatefulWidget {
  const News({super.key, required this.mainContext});
  final BuildContext mainContext;

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  int current = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
          // Search News
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              readOnly: false,
              autofocus: false,
              enabled: false,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      color: CupertinoColors.systemGrey,
                      width: 1.5,
                    )),
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search news here',
              ),
            ),
          ),
          // Carousel News
          Padding(
            padding: const EdgeInsets.only(top: 23.0, bottom: 5),
            child: CarouselSlider(
              items: imageSliders(
                imgList: imgList,
                mainContext: widget.mainContext,
              ),
              carouselController: controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2,
                  onPageChanged: (index, reason) =>
                      setState(() => current = index)),
            ),
          ),
          slideIndicator(
            context: context,
            controller: controller,
            current: current,
          ),
          // Popular News Cards
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              "Popular News",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          popularNews(context: context, mainContext: widget.mainContext),
          // Latest News Cards
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              "Latest News",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          latestNews(context: context, mainContext: widget.mainContext),
          const SizedBox(height: 40),
          // Latest News Cards
        ],
      ),
    );
  }

  Widget slideIndicator({
    required int current,
    required BuildContext context,
    required CarouselController controller,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: current == entry.key
                ? Container(
                    width: 20,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(
                        current == entry.key ? 0.9 : 0.4,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    child: const SizedBox(
                      height: 5,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      controller.animateToPage(entry.key);
                      setState(() {
                        current = entry.key;
                      });
                    },
                    child: Container(
                      width: 8,
                      height: 5,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(
                          current == entry.key ? 0.9 : 0.4,
                        ),
                      ),
                    ),
                  ),
          );
        }).toList(),
      );
}
