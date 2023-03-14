import 'package:flutter/material.dart';

import '../services/helpers.dart';

Widget listTileLoginActivity({
  required BuildContext context,
  required String deviceName,
  required String dateTime,
  required String deviceInfo,
  required String networkInfo,
}) =>
    ExpansionTile(
      title:
          Text(deviceName, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(dateTime),
      children: <Widget>[
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
