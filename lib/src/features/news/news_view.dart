import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/model/news_model.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/widgets/list_tile/list_tile_profile.dart';
import 'package:shimmer/shimmer.dart';
import '../../model/user_model.dart';
import '../../services/helpers.dart';
import 'package:dotted_line/dotted_line.dart';

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
  bool liked = false;

  @override
  void initState() {
    super.initState();
    liked = NewsService().isLike(news: widget.news, user: widget.user);
  }

  @override
  Widget build(BuildContext context) {
    final controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.news.jsonContent)),
      selection: const TextSelection.collapsed(offset: 0),
    );
    liked = NewsService().isLike(news: widget.news, user: widget.user);

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
      body: ListView(
        children: [
          // Thumbnail
          widget.news.imgURL == null
              ? Image.asset(
                  'assets/images/noimage.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.5,
                )
              : CachedNetworkImage(
                  imageUrl: widget.news.imgURL!,
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
          widget.news.thumbnailDescription == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Text(
                    widget.news.thumbnailDescription!,
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
          widget.news.category == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    widget.news.category!.toUpperCase(),
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
              widget.news.title,
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
              widget.news.description,
              style: TextStyle(
                color: getColorByBackground(context),
                fontSize: 20,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Author TODO view news by author
          widget.news.author == null
              ? const SizedBox()
              : listTileProfile(
                  context: context,
                  user: widget.news.author!,
                  includeEdit: false,
                ),
          // Date
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Text(
              "Posted on ${DateFormat('MMMM d, y').format(widget.news.createdAt)}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          widget.news.createdAt.year == widget.news.updatedAt.year &&
                  widget.news.createdAt.month == widget.news.updatedAt.month &&
                  widget.news.createdAt.day == widget.news.updatedAt.day &&
                  widget.news.createdAt.hour == widget.news.updatedAt.hour &&
                  widget.news.createdAt.minute == widget.news.updatedAt.minute
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(
                    "Updated on ${DateFormat('MMMM d, y').format(widget.news.updatedAt)}",
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
                OutlinedButton(
                  onPressed: () {}, // TODO bookmark
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                liked
                    ? OutlinedButton(
                        onPressed: () async {
                          dynamic result = await NewsService()
                              .unlike(news: widget.news, user: widget.user);
                          print("result: $result");

                          if (result == true) {
                            Fluttertoast.showToast(msg: "News unliked");
                            setState(() => liked = false);
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                    ' ${widget.news.likedBy == null ? 0 : widget.news.likedBy!.length}',
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
                              .like(news: widget.news, user: widget.user);
                          print("result: $result");

                          if (result == true) {
                            Fluttertoast.showToast(msg: "News liked");
                            setState(() => liked = true);
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                    ' ${widget.news.likedBy == null ? 0 : widget.news.likedBy!.length}',
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
                  onPressed: () =>
                      showComment(context, widget.news), // TODO comment
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "${02} comments",
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
          widget.news.tag == null
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
                          children: widget.news.tag!.map((tag) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: CustomColor.primary,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Text(
                                      "#$tag",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {}, // TODO view article by tag
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
                    border: Border.all(),
                    color: CustomColor.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    listTileProfile(
                      context: context,
                      user: widget.news.author!,
                      includeEdit: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        bottom: 30,
                      ),
                      child: Text(
                        "Anne Helen Petersen is a senior culture writer for BuzzFeed News and is based in Missoula, Montana.",
                        style: const TextStyle(
                          fontSize: 18,
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
              onPressed: () =>
                  showComment(context, widget.news), // TODO comment
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "2 COMMENTS",
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
        ],
      ),
    );
  }
}
