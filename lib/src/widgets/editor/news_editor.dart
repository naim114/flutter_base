import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/widgets/editor/image_uploader.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import '../../services/helpers.dart';

Widget newsEditor({
  required QuillController controller,
  required BuildContext context,
  String appBarTitle = "Add/Edit News",
}) =>
    Scaffold(
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
                title: const Text('Post News?'),
                content: const Text('Post news? Select OK to confirm.'),
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
                    onPressed: () {},
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
                builder: (context) => ImageUploader(
                  appBarTitle: "Upload Thumbnail",
                  width: 350,
                  height: 196.88,
                  onCancel: () => Navigator.of(context).pop(),
                  onConfirm: () {},
                ),
              ),
            ),
            title: const Text("Preview/Upload Thumbnail"),
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
              hintText: 'Enter title for this news',
              focusColor: CupertinoColors.systemGrey,
              hoverColor: CupertinoColors.systemGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: QuillToolbar.basic(controller: controller),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: QuillEditor.basic(
              controller: controller,
              readOnly: false,
            ),
          ),
        ],
      ),
    );
