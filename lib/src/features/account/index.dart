import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/account/about/index.dart';
import 'package:flutter_base/src/features/account/profile/index.dart';
import 'package:flutter_base/src/features/account/security/index.dart';
import 'package:flutter_base/src/features/admin/dashboard/index.dart';
import 'package:flutter_base/src/features/admin/index.dart';
import 'package:flutter_base/src/features/admin/settings/index.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/typography/page_title_icon.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../services/auth_services.dart';
import '../../widgets/list_tile/list_tile_icon.dart';
import '../../widgets/list_tile/list_tile_profile.dart';

class Account extends StatefulWidget {
  const Account({
    super.key,
    required this.mainContext,
  });

  final BuildContext mainContext;

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                    onEdit: () => Navigator.of(widget.mainContext).push(
                      MaterialPageRoute(
                        builder: (context) => Profile(user: user),
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
                    onTap: () => Navigator.of(widget.mainContext).push(
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
                  // About
                  listTileIcon(
                    context: context,
                    icon: Icons.info_outlined,
                    title: "About",
                    onTap: () => Navigator.of(widget.mainContext).push(
                      MaterialPageRoute(
                        builder: (context) => const AppAbout(),
                      ),
                    ),
                  ),
                  // ADMIN ONLY
                  user.role?.name == "user"
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              onTap: () =>
                                  Navigator.of(widget.mainContext).push(
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
                              onTap: () =>
                                  Navigator.of(widget.mainContext).push(
                                MaterialPageRoute(
                                  builder: (context) => const AdminPanel(),
                                ),
                              ),
                            ),
                            listTileIcon(
                              context: context,
                              icon: Icons.app_settings_alt,
                              title: "App Settings",
                              onTap: () =>
                                  Navigator.of(widget.mainContext).push(
                                MaterialPageRoute(
                                  builder: (context) => const AppSettings(),
                                ),
                              ),
                            ),
                          ],
                        ),
                  ListTile(
                    title: Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold),
                    ),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Log Out?'),
                        content: const Text('Select OK to log out.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _authService.signOut(user);
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                color: CustomColor.danger,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
