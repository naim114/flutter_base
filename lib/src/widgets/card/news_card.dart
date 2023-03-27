import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/helpers.dart';

Widget newsCard({
  required BuildContext context,
  required String imageURL,
  required String title,
  required int likeCount,
  required DateTime date,
}) =>
    Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromRGBO(25, 30, 34, 1)
          : Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageURL,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Text('Some errors occurred!'),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
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
                              text: " ${DateFormat('dd/MM/yyyy').format(date)}",
                              style: TextStyle(
                                color: getColorByBackground(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      RichText(
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
                              text: " $likeCount",
                              style: TextStyle(
                                color: getColorByBackground(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
