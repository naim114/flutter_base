import 'package:flutter/material.dart';

import '../../services/helpers.dart';

Widget listTileActivity({
  required BuildContext context,
  required String deviceName,
  required String dateTime,
  required String deviceInfo,
  required String networkInfo,
  String action = "",
}) =>
    ExpansionTile(
      title: Text(
        action != "" ? action : deviceName,
        style: const TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(dateTime),
      children: <Widget>[
        action != ""
            ? ListTile(
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(color: getColorByBackground(context)),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'Action: \n',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: action),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
        ListTile(
          title: RichText(
            text: TextSpan(
              style: TextStyle(color: getColorByBackground(context)),
              children: <TextSpan>[
                const TextSpan(
                    text: 'Date Time: \n',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: dateTime),
              ],
            ),
          ),
        ),
        ListTile(
          title: RichText(
            text: TextSpan(
              style: TextStyle(color: getColorByBackground(context)),
              children: <TextSpan>[
                const TextSpan(
                    text: 'Device info: \n',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: deviceInfo),
              ],
            ),
          ),
        ),
        ListTile(
          title: RichText(
            text: TextSpan(
              style: TextStyle(color: getColorByBackground(context)),
              children: <TextSpan>[
                const TextSpan(
                    text: 'Network info: \n',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: networkInfo),
              ],
            ),
          ),
        ),
      ],
    );
