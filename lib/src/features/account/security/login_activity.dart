import 'package:flutter/material.dart';

import '../../../services/helpers.dart';

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
          ExpansionTile(
            title: const Text('device_name',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('device_ip'),
            children: <Widget>[
              ListTile(
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(color: getColorByBackground(context)),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Device info: \n',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'device_info_here'),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(color: getColorByBackground(context)),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Network info: \n',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'device_info_here'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
