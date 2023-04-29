import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/model/comment_model.dart';
import 'package:news_app/src/model/news_model.dart';
import 'package:news_app/src/services/comment_services.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/widgets/list_tile/list_tile_profile.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:shimmer/shimmer.dart';
import '../../model/user_model.dart';
import '../../services/helpers.dart';
import '../../widgets/card/news_card_simple.dart';

class NewsView extends StatefulWidget {
  final BuildContext mainContext;
  final NewsModel news;
  final UserModel user;

  const NewsView({
    super.key,
    required this.mainContext,
    required this.news,
    required this.user,
  });

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Object?> allList = [
    [],
    [],
  ];

  Future<void> _refreshData() async {
    try {
      final NewsModel? news = await NewsService().get(widget.news.id);
      final List<CommentModel?> comments =
          await CommentServices().getByNews(widget.news);

      setState(() {
        allList = [
          news,
          comments,
        ];
      });

      // Trigger a refresh of the RefreshIndicator widget
      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Error Get All News:  ${e.toString()}");
    }

    setState(() {});
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
          "News",
          style: TextStyle(
            color: getColorByBackground(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: Future.wait([
            NewsService().get(widget.news.id),
            CommentServices().getByNews(widget.news)
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text(
                "Error loading news. Please try again",
                style: TextStyle(color: CupertinoColors.systemGrey),
              ));
            } else if (!snapshot.hasData ||
                snapshot.data![0] == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            NewsModel? news = snapshot.data![0] as NewsModel?;
            List<CommentModel?>? comments =
                snapshot.data![1] as List<CommentModel?>?;

            final controller = QuillController(
              document: Document.fromJson(jsonDecode(news!.jsonContent)),
              selection: const TextSelection.collapsed(offset: 0),
            );

            return ListView(
              children: [
                // Thumbnail
                news.imgURL == null
                    ? Image.asset(
                        'assets/images/noimage.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.5,
                      )
                    : CachedNetworkImage(
                        imageUrl: news.imgURL!,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.5,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: CupertinoColors.systemGrey,
                          highlightColor: CupertinoColors.systemGrey2,
                          child: Container(
                            color: Colors.grey,
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/noimage.png',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                // Thumbnail Desc
                news.thumbnailDescription == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text(
                          news.thumbnailDescription!,
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                // Category TODO view news by category
                news.category == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          news.category!.toUpperCase(),
                          style: const TextStyle(
                            color: CustomColor.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                // Title
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    news.title,
                    style: TextStyle(
                      color: getColorByBackground(context),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Description
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                  ),
                  child: Text(
                    news.description,
                    style: TextStyle(
                      color: getColorByBackground(context),
                      fontSize: 20,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Author TODO view news by author
                news.author == null
                    ? const SizedBox()
                    : listTileProfile(
                        context: context,
                        user: news.author!,
                        includeEdit: false,
                      ),
                // Date
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                  child: Text(
                    "Posted on ${DateFormat('MMMM d, y').format(news.createdAt)}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                news.createdAt.year == news.updatedAt.year &&
                        news.createdAt.month == news.updatedAt.month &&
                        news.createdAt.day == news.updatedAt.day &&
                        news.createdAt.hour == news.updatedAt.hour &&
                        news.createdAt.minute == news.updatedAt.minute
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          "Updated on ${DateFormat('MMMM d, y').format(news.updatedAt)}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                // Bookmark, Like, Comment
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      NewsService().isBookmark(news: news, user: widget.user)
                          ? OutlinedButton(
                              onPressed: () async {
                                dynamic result = await NewsService()
                                    .unbookmark(news: news, user: widget.user);
                                print("result: $result");

                                if (result == true) {
                                  Fluttertoast.showToast(
                                      msg: "News unbookmarked");
                                }

                                _refreshData();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.bookmark,
                                color: CustomColor.secondary,
                              ),
                            )
                          : OutlinedButton(
                              onPressed: () async {
                                dynamic result = await NewsService()
                                    .bookmark(news: news, user: widget.user);
                                print("result: $result");

                                if (result == true) {
                                  Fluttertoast.showToast(
                                      msg: "News bookmarked");
                                }

                                _refreshData();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.bookmark,
                                color: getColorByBackground(context),
                              ),
                            ),
                      const SizedBox(width: 5),
                      NewsService().isLike(news: news, user: widget.user)
                          ? OutlinedButton(
                              onPressed: () async {
                                dynamic result = await NewsService()
                                    .unlike(news: news, user: widget.user);
                                print("result: $result");

                                if (result == true) {
                                  Fluttertoast.showToast(msg: "News unliked");
                                }

                                _refreshData();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(
                                        CupertinoIcons.heart_fill,
                                        size: 14,
                                        color: CustomColor.danger,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${news.likedBy == null ? 0 : news.likedBy!.length}',
                                      style: TextStyle(
                                        color: getColorByBackground(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : OutlinedButton(
                              onPressed: () async {
                                dynamic result = await NewsService()
                                    .like(news: news, user: widget.user);
                                print("result: $result");

                                if (result == true) {
                                  Fluttertoast.showToast(msg: "News liked");
                                }

                                _refreshData();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        CupertinoIcons.heart_fill,
                                        size: 14,
                                        color: getColorByBackground(context),
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${news.likedBy == null ? 0 : news.likedBy!.length}',
                                      style: TextStyle(
                                        color: getColorByBackground(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(width: 5),
                      OutlinedButton(
                        onPressed: () => CommentServices().showComment(
                          context,
                          news,
                          widget.user,
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "${comments == null ? 0 : comments.length} comments",
                          style: TextStyle(
                            color: getColorByBackground(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Article
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 30,
                    top: 20,
                  ),
                  child: QuillEditor(
                    controller: controller,
                    readOnly: true,
                    autoFocus: false,
                    expands: false,
                    focusNode: FocusNode(),
                    padding: const EdgeInsets.all(0),
                    scrollController: ScrollController(),
                    scrollable: true,
                    showCursor: false,
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  dashColor: getColorByBackground(context),
                ),
                // Tag
                news.tag == null
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              top: 20,
                              bottom: 15,
                            ),
                            child: Text(
                              "Topics in this article",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              bottom: 30,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: news.tag!.map((tag) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      color: CustomColor.primary,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Text(
                                            "#$tag",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          onTap:
                                              () {}, // TODO view article by tag
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            dashColor: getColorByBackground(context),
                          ),
                        ],
                      ),
                // Author box
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 15,
                  ),
                  child: InkWell(
                    onTap: () {}, // TODO view news by author
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: CustomColor.primary),
                          color: CustomColor.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          listTileProfile(
                            context: context,
                            user: news.author!,
                            includeEdit: false,
                            fontColor: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              bottom: 30,
                            ),
                            child: Text(
                              news.author!.bio ??
                                  "Tap to read more article from ${news.author!.name}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Comment
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: OutlinedButton(
                    onPressed: () => CommentServices().showComment(
                      context,
                      news,
                      widget.user,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "${comments == null ? 0 : comments.length} COMMENTS",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                // Recommendation (Latest/ Star)
                FutureBuilder(
                  future: Future.wait([
                    NewsService().getAllBy(
                      fieldName: 'createdAt',
                      desc: true,
                      limit: 3,
                    ),
                    NewsService().getAllBy(
                      fieldName: 'starred',
                      desc: true,
                      limit: 3,
                    ),
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final List<NewsModel?> latestNewsList = snapshot.data![0];
                    final List<NewsModel?> starredNewsList = snapshot.data![1];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 20,
                            bottom: 15,
                          ),
                          child: Text(
                            "MORE NEWS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            latestNewsList.length,
                            (index) {
                              NewsModel? news = latestNewsList[index];

                              return news == null
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: newsCardSimple(
                                        context: context,
                                        news: news,
                                        user: widget.user,
                                      ),
                                    );
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 20,
                            bottom: 15,
                          ),
                          child: Text(
                            "EDITOR'S PICK",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            starredNewsList.length,
                            (index) {
                              NewsModel? news = starredNewsList[index];

                              return news == null
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: newsCardSimple(
                                        context: context,
                                        news: news,
                                        user: widget.user,
                                      ),
                                    );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ),
    );
  }
}
