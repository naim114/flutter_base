import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../services/helpers.dart';
import '../../../widgets/text_editor/notification_editor.dart';

class EditNotification extends StatefulWidget {
  const EditNotification({super.key});

  @override
  State<EditNotification> createState() => _EditNotificationState();
}

class _EditNotificationState extends State<EditNotification> {
  final _controller = QuillController(
    document: Document()..insert(0, 'TODO get notification to edited here'),
    selection: const TextSelection.collapsed(offset: 0),
  );

  @override
  Widget build(BuildContext context) {
    return notificationEditor(
      context: context,
      controller: _controller,
      appBarTitle: "Add Notification",
    );
  }
}
