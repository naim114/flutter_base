import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../../widgets/editor/notification_editor.dart';

class EditNotification extends StatelessWidget {
  EditNotification({super.key});

  final _controller = QuillController(
    document: Document()..insert(0, 'TODO get notification to edited here'),
    selection: const TextSelection.collapsed(offset: 0),
  );

  @override
  Widget build(BuildContext context) {
    return NotificationEditor(
      context: context,
      controller: _controller,
      appBarTitle: "Add Notification",
      onPost: (editedController) {},
    );
  }
}
