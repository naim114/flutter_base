import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/notification_model.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../../model/user_model.dart';
import '../../../widgets/editor/notification_editor.dart';

class EditNotification extends StatelessWidget {
  final UserModel currentUser;
  final NotificationModel notification;

  const EditNotification({
    super.key,
    required this.currentUser,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final controller = QuillController(
      document: Document.fromJson(jsonDecode(notification.jsonContent)),
      selection: const TextSelection.collapsed(offset: 0),
    );

    return NotificationEditor(
      context: context,
      controller: controller,
      appBarTitle: "Edit Notification",
      onPost: (callBackController, receiverList, title) {},
      currentUser: currentUser,
      title: notification.title,
    );
  }
}
