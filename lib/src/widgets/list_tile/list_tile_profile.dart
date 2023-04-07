import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/helpers.dart';

Widget listTileProfile({
  required BuildContext context,
  required void Function() onEdit,
  required UserModel user,
}) {
  String name = user.name ?? "No Name";

  return ListTile(
    leading: SizedBox(
      width: MediaQuery.of(context).size.height * 0.06,
      child: user.avatarURL == null
          ? Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.height * 0.06,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/default-profile-picture.png'),
                    fit: BoxFit.cover),
              ),
            )
          : CachedNetworkImage(
              imageUrl: user.avatarURL!,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: CupertinoColors.systemGrey,
                highlightColor: CupertinoColors.systemGrey2,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.height * 0.06,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
              ),
              errorWidget: (context, url, error) {
                print("Avatar Error: $error");
                return Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.height * 0.06,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/default-profile-picture.png'),
                        fit: BoxFit.cover),
                  ),
                );
              },
            ),
    ),
    title: Text(
      name != " " && name != "" ? name : "No Name",
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
}
