import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/account/security/login_activity.dart';
import 'package:flutter_base/src/features/account/security/update_email.dart';
import 'package:flutter_base/src/features/account/security/update_password.dart';

import '../../../services/helpers.dart';
import '../../../widgets/list_tile/list_tile_icon.dart';

class Security extends StatelessWidget {
  const Security({super.key});

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
          "Security",
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
            icon: Icons.email,
            title: "Update Email",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UpdateEmail(),
              ),
            ),
          ),
          listTileIcon(
            context: context,
            icon: Icons.key,
            title: "Update Password",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UpdatePassword(),
              ),
            ),
          ),
          listTileIcon(
            context: context,
            icon: Icons.pin_drop,
            title: "Login activity",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginActivity(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
