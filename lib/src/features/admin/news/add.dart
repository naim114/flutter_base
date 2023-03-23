import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import '../../../widgets/editor/news_editor.dart';

class AddNews extends StatelessWidget {
  AddNews({super.key});

  final _controller = QuillController(
    document: Document()..insert(0, 'Write your article here'),
    selection: const TextSelection.collapsed(offset: 0),
  );

  @override
  Widget build(BuildContext context) {
    return newsEditor(
      context: context,
      controller: _controller,
      appBarTitle: "Add News",
    );
  }
}
