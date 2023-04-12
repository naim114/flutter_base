import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/widgets/editor/image_uploader.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/helpers.dart';

class NewsEditor extends StatefulWidget {
  final QuillController controller;
  final BuildContext context;
  final String appBarTitle;
  final File? thumbnailFile;
  final Function(
    QuillController quillController,
    File? thumbnailFile,
    String title,
  ) onPost;

  const NewsEditor({
    super.key,
    required this.controller,
    required this.context,
    this.appBarTitle = "Add/Edit News",
    this.thumbnailFile,
    required this.onPost,
  });

  @override
  State<NewsEditor> createState() => _NewsEditorState();
}

class _NewsEditorState extends State<NewsEditor> {
  File? _thumbnailFile;
  final TextEditingController titleController = TextEditingController();

  bool _submitted = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _thumbnailFile = widget.thumbnailFile;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  bool post() {
    setState(() => _submitted = true);
    Navigator.pop(context);

    if (titleController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Title can't be empty");

      return false;
    }

    setState(() => _loading = true);

    Future.delayed(const Duration(seconds: 1), () {
      widget.onPost(widget.controller, _thumbnailFile, titleController.text);
      // Navigator.pop(context);
    });

    return true;
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
          widget.appBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
        actions: _loading
            ? []
            : [
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageUploader(
                        appBarTitle: "Upload Thumbnail",
                        width: 350,
                        height: 196.88,
                        onCancel: () => Navigator.of(context).pop(),
                        onConfirm: (imageFile, uploaderContext) {
                          setState(() => _thumbnailFile = imageFile);
                        },
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
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    labelText: 'Title',
                    hintText: 'Enter title for this news',
                    focusColor: CupertinoColors.systemGrey,
                    hoverColor: CupertinoColors.systemGrey,
                    errorText: _submitted == true & titleController.text.isEmpty
                        ? "Title can't be empty"
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: QuillToolbar.basic(
                    controller: widget.controller,
                  ),
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
