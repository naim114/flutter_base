import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/material.dart';

import '../../../services/helpers.dart';
import '../../../widgets/text_editor/notification_editor.dart';

class AddNotification extends StatefulWidget {
  const AddNotification({super.key});

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  final _controller = QuillController(
    document: Document()..insert(0, 'Write your notification here'),
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
