import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:fluttertoast/fluttertoast.dart';
import '../../../model/user_model.dart';
import '../../../services/news_services.dart';
import '../../../widgets/editor/news_editor.dart';

class EditNews extends StatelessWidget {
  const EditNews({super.key, required this.currentUser});
  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    final controller = QuillController(
      document: Document()..insert(0, 'TODO get news to edited here'),
      selection: const TextSelection.collapsed(offset: 0),
    );

    return NewsEditor(
      context: context,
      controller: controller,
      appBarTitle: "Edit News",
      onPost: (quillController, thumbnailFile, title) async {
        var result;

        // if (thumbnailFile != null) {
        //   result = await NewsService().edit(
        //     title: title,
        //     jsonContent:
        //         jsonEncode(quillController.document.toDelta().toJson()),
        //     author: currentUser,
        //     imageFile: thumbnailFile,
        //   );
        // } else {
        //   result = await NewsService().edit(
        //     title: title,
        //     jsonContent:
        //         jsonEncode(quillController.document.toDelta().toJson()),
        //     author: currentUser,
        //   );
        // }

        if (result == true && context.mounted) {
          Fluttertoast.showToast(msg: "News posted");
          Navigator.pop(context);
        }
      },
    );
  }
}
