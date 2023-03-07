import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../services/helpers.dart';

Widget listTileNotification({
  required void Function(BuildContext) onMarkUnread,
  required void Function(BuildContext) onDelete,
  required void Function() onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onMarkUnread,
              backgroundColor: CustomColor.neutral2,
              foregroundColor: Colors.white,
              icon: Icons.mark_as_unread,
              label: 'Mark Unread',
            ),
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: CustomColor.danger,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: const ListTile(
          title: Text(
            'Notifications title',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Mar 18 2014'),
          trailing: Icon(
            Icons.circle,
            color: CustomColor.secondary,
          ),
        ),
      ),
    );
