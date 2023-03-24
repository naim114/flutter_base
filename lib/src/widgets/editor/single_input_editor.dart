import 'package:flutter/material.dart';
import 'package:flutter_base/src/widgets/appbar/appbar_confirm_cancel.dart';

class SingleInputEditor extends StatelessWidget {
  final String appBarTitle;
  final String textFieldLabel;
  final void Function() onCancel;
  final void Function() onConfirm;
  final String description;

  const SingleInputEditor({
    super.key,
    required this.appBarTitle,
    required this.textFieldLabel,
    required this.onCancel,
    required this.onConfirm,
    this.description = "Tap on top right to confirm changes.",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConfirmCancel(
        context: context,
        onCancel: onCancel,
        onConfirm: onConfirm,
        title: appBarTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: ListView(
          children: [
            Text(description),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: textFieldLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
