import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/helpers.dart';

void _defaultFunction() {}

PreferredSizeWidget customAppBar({
  required BuildContext context,
  void Function() onPressed = _defaultFunction,
  List<Widget>? actions,
  String title = '',
  bool noBackButton = false,
}) {
  return AppBar(
    actions: actions,
    leading: noBackButton
        ? null
        : IconButton(
            onPressed: noBackButton ? null : onPressed,
            color: getColorByBackground(context),
            icon: const Icon(
              CupertinoIcons.back,
            ),
          ),
    title: Text(
      title,
      style: TextStyle(
        color: getColorByBackground(context),
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
  );
}
