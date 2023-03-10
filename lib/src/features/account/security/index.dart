import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_base/src/widgets/list_tile_icon.dart';

import '../../../services/helpers.dart';

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
        title: const Text(
          "Security",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          listTileIcon(
            context: context,
            icon: Icons.key,
            title: "Password",
            onTap: () {},
          ),
          listTileIcon(
            context: context,
            icon: Icons.pin_drop,
            title: "Login activity",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
