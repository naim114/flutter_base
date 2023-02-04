import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/page_title_icon.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            pageTitleIcon(
              context: context,
              title: "Inbox",
              icon: const Icon(
                CupertinoIcons.mail_solid,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
