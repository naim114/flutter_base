import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../widgets/text_editor/news_editor.dart';

class EditNews extends StatelessWidget {
  EditNews({super.key});

  final _controller = QuillController(
    document: Document()..insert(0, 'TODO get news to edited here'),
    selection: const TextSelection.collapsed(offset: 0),
  );

  @override
  Widget build(BuildContext context) {
    return newsEditor(
      context: context,
      controller: _controller,
      appBarTitle: "Edit News",
    );
  }
}
