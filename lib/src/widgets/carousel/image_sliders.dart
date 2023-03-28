import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

List<Widget> imageSliders({
  required List<String> imgList,
}) =>
    imgList
        .map((item) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: 1000.0,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Shimmer.fromColors(
                      baseColor: CupertinoColors.systemGrey,
                      highlightColor: CupertinoColors.systemGrey2,
                      child: Container(
                        color: Colors.grey,
                        height: 500,
                        width: 1000,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Some errors occurred!'),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        "The costs of financing education and risk of elite capture.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                                text: " 22/3/2023",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )))
        .toList();
