import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/model/user_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/helpers.dart';

Widget listTileProfile({
  required BuildContext context,
  void Function()? onEdit,
  required UserModel user,
  bool includeEmail = true,
  bool includeEdit = true,
  Color? fontColor,
}) {
  Color defaultColor = fontColor ?? getColorByBackground(context);

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
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    ),
    title: Text(
      user.name,
      style: TextStyle(fontWeight: FontWeight.bold, color: defaultColor),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
    subtitle: includeEmail
        ? Text(
            user.email,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: defaultColor),
          )
        : null,
    contentPadding: const EdgeInsets.all(15),
    trailing: includeEdit
        ? OutlinedButton(
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
                      color: defaultColor,
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      CupertinoIcons.pencil,
                      size: 14,
                      color: defaultColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        : null,
  );
}
