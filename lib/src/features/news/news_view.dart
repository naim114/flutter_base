import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/news_model.dart';
import 'package:flutter_base/src/services/news_services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../services/helpers.dart';

class NewsView extends StatefulWidget {
  final BuildContext mainContext;
  final NewsModel news;

  const NewsView({
    super.key,
    required this.mainContext,
    required this.news,
  });

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    final controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.news.jsonContent)),
      selection: const TextSelection.collapsed(offset: 0),
    );

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
        actions: [
          IconButton(
            onPressed: () async {
              dynamic result = await NewsService().like(news: widget.news);
              print("result: $result");

              if (result == true) {
                Fluttertoast.showToast(msg: "News liked");
                setState(() => liked = true);
              }
            },
            icon: liked
                ? const Icon(
                    CupertinoIcons.heart_fill,
                    color: CustomColor.danger,
                  )
                : const Icon(CupertinoIcons.heart),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 15,
            ),
            child: Text(
              widget.news.title,
              style: TextStyle(
                color: getColorByBackground(context),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          widget.news.imgURL == null
              ? Image.asset(
                  'assets/images/noimage.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.4,
                )
              : CachedNetworkImage(
                  imageUrl: widget.news.imgURL!,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.4,
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
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    widget.news.author!.name ?? "No Name",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.access_time,
                            size: 14,
                            color: getColorByBackground(context),
                          ),
                        ),
                        TextSpan(
                          text:
                              " ${DateFormat('dd/MM/yyyy').format(widget.news.createdAt)}",
                          style: TextStyle(
                            color: getColorByBackground(context),
                          ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 10),
                        ),
                        WidgetSpan(
                          child: Icon(
                            CupertinoIcons.heart_fill,
                            size: 14,
                            color: getColorByBackground(context),
                          ),
                        ),
                        TextSpan(
                          text: " ${widget.news.likeCount}",
                          style: TextStyle(
                            color: getColorByBackground(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}
