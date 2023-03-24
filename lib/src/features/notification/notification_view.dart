import 'package:flutter/material.dart';

import '../../services/helpers.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

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
          "TODO Notification title Here",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Text('JSON from document here'),
          ),
        ],
      ),
    );
  }
}
