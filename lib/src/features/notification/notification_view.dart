import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import '../../services/helpers.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final controller = QuillController(
    document: Document.fromJson(jsonDecode(r"""
    [
      {
        "insert": "Flutter Quill"
      },
      {
        "attributes": {
          "header": 1
        },
        "insert": "\n"
      },
      {
        "insert": "\nRich text editor for Flutter"
      },
      {
        "attributes": {
          "header": 2
        },
        "insert": "\n"
      },
      {
        "insert": "Quill component for Flutter"
      },
      {
        "attributes": {
          "header": 3
        },
        "insert": "\n"
      },
      {
        "insert": "\nTrack personal and group journals (ToDo, Note, Ledger) from multiple views with timely reminders"
      },
      {
        "attributes": {
          "list": "ordered"
        },
        "insert": "\n"
      },
      {
        "insert": "Share your tasks and notes with teammates, and see changes as they happen in real-time, across all devices"
      },
      {
        "attributes": {
          "list": "ordered"
        },
        "insert": "\n"
      },
      {
        "insert": "Check out what you and your teammates are working on each day"
      },
      {
        "attributes": {
          "list": "ordered"
        },
        "insert": "\n"
      },
      {
        "insert": "\nSplitting bills with friends can never be easier."
      },
      {
        "attributes": {
          "list": "bullet"
        },
        "insert": "\n"
      },
      {
        "insert": "Start creating a group and invite your friends to join."
      },
      {
        "attributes": {
          "list": "bullet"
        },
        "insert": "\n"
      },
      {
        "insert": "Create a BuJo of Ledger type to see expense or balance summary."
      },
      {
        "attributes": {
          "list": "bullet"
        },
        "insert": "\n"
      }
    ]
    """)),
    selection: const TextSelection.collapsed(offset: 0),
  );

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
          "Small U.S. banks see record drop in deposits after SVB collapse.",
          style: TextStyle(
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: QuillEditor.basic(
              controller: controller,
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
