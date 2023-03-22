import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/helpers.dart';
import '../../../widgets/list_tile/list_tile_icon.dart';

class AppAbout extends StatelessWidget {
  const AppAbout({super.key});
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
          "About",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: ListView(
        children: [
          listTileIcon(
            context: context,
            icon: Icons.open_in_new_outlined,
            title: "Copyright",
            onTap: () => goToURL(
              context: context,
              url: Uri.parse('https://github.com/naim114'),
            ),
          ),
          listTileIcon(
            context: context,
            icon: Icons.open_in_new_outlined,
            title: "Privacy Policy",
            onTap: () => goToURL(
              context: context,
              url: Uri.parse('https://github.com/naim114'),
            ),
          ),
          listTileIcon(
            context: context,
            icon: Icons.open_in_new_outlined,
            title: "Terms & Conditions",
            onTap: () => goToURL(
              context: context,
              url: Uri.parse('https://github.com/naim114'),
            ),
          ),
          listTileIcon(
            context: context,
            icon: Icons.open_in_new_outlined,
            title: "Open Source Libraries",
            // TODO https://pub.dev/packages/flutter_oss_licenses
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Placeholder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
