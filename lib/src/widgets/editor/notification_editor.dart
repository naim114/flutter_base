import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/widgets/builder/user_builder.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../model/user_model.dart';
import '../../services/helpers.dart';

class NotificationEditor extends StatefulWidget {
  final QuillController controller;
  final BuildContext context;
  final Function(QuillController quillController, List<UserModel> receiverList)
      onPost;
  final UserModel currentUser;

  const NotificationEditor({
    super.key,
    required this.controller,
    required this.context,
    String appBarTitle = "Add/Edit Notification",
    required this.onPost,
    required this.currentUser,
  });

  @override
  State<NotificationEditor> createState() => _NotificationEditorState();
}

class _NotificationEditorState extends State<NotificationEditor> {
  final String appBarTitle = "Add/Edit Notification";

  List<UserModel> receiverList = List.empty();

  void post() {
    print("receiverList: $receiverList");
    widget.onPost(widget.controller, receiverList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColor.neutral2,
          ),
        ),
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Post Notification?'),
                content:
                    const Text('Post notifications? Select OK to confirm.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: post,
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Text("Post"),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UsersBuilder(
                  currentUser: widget.currentUser,
                  pushTo: 'UsersPicker',
                  onPost: (userList, pickerContext) {
                    print("notification editor: $userList");
                    setState(() => receiverList = userList);
                    Navigator.pop(pickerContext);
                  },
                ),
              ),
            ),
            title: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Send to: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: 'All'),
                ],
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            shape: const Border(
              bottom: BorderSide(
                width: 1,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              labelText: 'Title',
              hintText: 'Enter title for this notification',
              focusColor: CupertinoColors.systemGrey,
              hoverColor: CupertinoColors.systemGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: QuillToolbar.basic(controller: widget.controller),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: QuillEditor.basic(
              controller: widget.controller,
              readOnly: false,
            ),
          ),
        ],
      ),
    );
  }
}
