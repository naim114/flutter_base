import 'package:flutter/material.dart';

import '../../../services/helpers.dart';
import '../../../widgets/list_tile_login_activity.dart';

class LoginActivity extends StatelessWidget {
  const LoginActivity({super.key});

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
          "Login Activity",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: ListView(
        children: [
          listTileLoginActivity(
            context: context,
            deviceName: 'iPhone X',
            dateTime: '15 March 2023',
            deviceInfo: 'blablabalbalbablalab',
            networkInfo: 'blablabalbalbablalab',
          ),
          listTileLoginActivity(
            context: context,
            deviceName: 'Samsung Something',
            dateTime: '11 December 2020',
            deviceInfo: 'blablabalbalbablalab',
            networkInfo: 'blablabalbalbablalab',
          ),
        ],
      ),
    );
  }
}
