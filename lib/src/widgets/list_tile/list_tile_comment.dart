import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/helpers.dart';

Widget listTileComment({
  required BuildContext context,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.05,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/default-profile-picture.png'),
                fit: BoxFit.cover),
          ),
        ),
        trailing: IconButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Delete Comment?'),
              content: const Text('Select OK to delete.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO DELETE COMMENT
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: CustomColor.danger),
                  ),
                ),
              ],
            ),
          ),
          icon: const Icon(
            Icons.delete_forever,
            color: CustomColor.danger,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name Here",
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "5 years ago",
              style: const TextStyle(color: CupertinoColors.systemGrey),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            "In 1968, Mr. Belafonte filled in for Johnny Carson for five nights on The Tonight Show. Peacock released an outstanding documentary, The Sit-In: Harry Belafonte Hosts The Tonight Show. This was significant for many reasons - the Vietnam War was escalating, riots were breaking out all over the US, and he booked guests including RFK, Aretha Franklin, Dr. Martin Luther King Jr. and Sidney Poitier. It was unprecedented and should be noted.",
          ),
        ),
      ),
    );
