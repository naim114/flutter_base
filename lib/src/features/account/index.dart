import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/account/profile/index.dart';
import 'package:flutter_base/src/features/account/security/index.dart';
import 'package:flutter_base/src/features/admin/dashboard/index.dart';
import 'package:flutter_base/src/features/admin/index.dart';
import 'package:flutter_base/src/features/admin/settings/index.dart';
import 'package:flutter_base/src/features/auth/log_in.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/typography/page_title_icon.dart';

import '../../widgets/list_tile/list_tile_icon.dart';
import '../../widgets/list_tile/list_tile_profile.dart';

class Account extends StatelessWidget {
  const Account({
    super.key,
    required this.mainContext,
  });

  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            pageTitleIcon(
              context: context,
              title: "Account",
              icon: const Icon(
                CupertinoIcons.person_fill,
                size: 24,
              ),
            ),
            // PROFILE
            listTileProfile(
              context: context,
              onEdit: () => Navigator.of(mainContext).push(
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              ),
            ),
            // SETTINGS
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Security (Password, Login activity)
            listTileIcon(
              context: context,
              icon: CupertinoIcons.shield_lefthalf_fill,
              title: "Security",
              onTap: () => Navigator.of(mainContext).push(
                MaterialPageRoute(
                  builder: (context) => const Security(),
                ),
              ),
            ),
            // Theme
            listTileIcon(
              context: context,
              icon: isDarkTheme(context)
                  ? CupertinoIcons.moon_fill
                  : CupertinoIcons.sun_max_fill,
              title: "Theme",
              onTap: () => selectThemeMode(context),
            ),
            // ADMIN ONLY
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'Admin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Admin Dashboard
            listTileIcon(
              context: context,
              icon: CupertinoIcons.chart_bar_alt_fill,
              title: "Dashboard",
              onTap: () => Navigator.of(mainContext).push(
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
              ),
            ),
            // Admin Panel
            listTileIcon(
              context: context,
              icon: Icons.admin_panel_settings,
              title: "Admin Panel",
              onTap: () => Navigator.of(mainContext).push(
                MaterialPageRoute(
                  builder: (context) => const AdminPanel(),
                ),
              ),
            ),
            listTileIcon(
              context: context,
              icon: Icons.app_settings_alt,
              title: "App Settings",
              onTap: () => Navigator.of(mainContext).push(
                MaterialPageRoute(
                  builder: (context) => const AppSettings(),
                ),
              ),
            ),

            // Log Out TODO DISPLAY A POPUP TO CONFIRM LOGOUT
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.red[400], fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.of(mainContext).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LogIn(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
