import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../services/helpers.dart';

class NewsView extends StatelessWidget {
  final BuildContext mainContext;

  const NewsView({
    super.key,
    required this.mainContext,
  });

  @override
  Widget build(BuildContext context) {
    final controller = QuillController(
      document: Document.fromJson(jsonDecode(r"""
    [
      {
        "insert": "\nRich text editor for Flutter"
      },
      {
        "attributes": {
          "header": 2
        },
        "insert": "\n"
      },
      {
        "insert": "Quill component for Flutter"
      },
      {
        "attributes": {
          "header": 3
        },
        "insert": "\n"
      },
      {
        "insert": "\nTrack personal and group journals (Note, Ledger) from multiple views with timely reminders"
      },
      {
        "attributes": {
          "list": "ordered"
        },
        "insert": "\n"
      },
      {
        "insert": "Share your tasks and notes with teammates, and see changes as they happen in real-time, across all devices"
      },
      {
        "attributes": {
          "list": "ordered"
        },
        "insert": "\n"
      },
      {
        "insert": "Check out what you and your teammates are working on each day"
      },
      {
        "attributes": {
          "list": "ordered"
        },
        "insert": "\n"
      },
      {
        "insert": "\nSplitting bills with friends can never be easier."
      },
      {
        "attributes": {
          "list": "bullet"
        },
        "insert": "\n"
      },
      {
        "insert": "Start creating a group and invite your friends to join."
      },
      {
        "attributes": {
          "list": "bullet"
        },
        "insert": "\n"
      },
      {
        "insert": "Create a BuJo of Ledger type to see expense or balance summary."
      },
      {
        "attributes": {
          "list": "bullet"
        },
        "insert": "\n"
      }
    ]
    """)),
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
          ),
        ),
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
              "Small U.S. banks see record drop in deposits after SVB collapse.",
              style: TextStyle(
                color: getColorByBackground(context),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CachedNetworkImage(
            imageUrl:
                'https://sunnycrew.jp/wp-content/themes/dp-colors/img/post_thumbnail/noimage.png',
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
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                const Text(
                  "Author Name Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                RichText(
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
                            " ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
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
                        text: " 20",
                        style: TextStyle(
                          color: getColorByBackground(context),
                        ),
                      ),
                    ],
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
