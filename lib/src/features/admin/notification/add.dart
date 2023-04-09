import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/material.dart';
import '../../../model/user_model.dart';
import '../../../widgets/editor/notification_editor.dart';

class AddNotification extends StatelessWidget {
  AddNotification({super.key, required this.currentUser});
  final UserModel currentUser;

  final _controller = QuillController(
    document: Document()..insert(0, 'Write your notification here'),
    selection: const TextSelection.collapsed(offset: 0),
  );

  @override
  Widget build(BuildContext context) {
    return NotificationEditor(
      context: context,
      controller: _controller,
      appBarTitle: "Add Notification",
      onPost: (callbackController, receiverList) {
        print("Send to: ${receiverList.toString()}");
      },
      currentUser: currentUser,
    );
  }
}
