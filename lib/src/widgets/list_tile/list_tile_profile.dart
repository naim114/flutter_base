import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';

import '../../services/helpers.dart';

Widget listTileProfile({
  required UserModel user,
  required BuildContext context,
  required void Function() onEdit,
}) =>
    ListTile(
      leading: const CircleAvatar(
        backgroundImage:
            AssetImage('assets/images/default-profile-picture.png'),
      ),
      title: Text(
        user.name ?? 'No Name',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(user.email, overflow: TextOverflow.ellipsis),
      contentPadding: const EdgeInsets.all(15),
      trailing: OutlinedButton(
        onPressed: onEdit,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Edit ',
                style: TextStyle(
                  fontSize: 14,
                  color: getColorByBackground(context),
                ),
              ),
              WidgetSpan(
                child: Icon(
                  CupertinoIcons.pencil,
                  size: 14,
                  color: getColorByBackground(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
