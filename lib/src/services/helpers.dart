import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_picker_dialog.dart';

class CustomColor {
  static const primary = Color(0xFF643FDB);
  static const secondary = Color(0xFFFF8A00);
  static const neutral1 = Color(0xFF1C1243);
  static const neutral2 = Color(0xFFA29EB6);
  static const neutral3 = Color(0xFFEFF1F3);
  static const semantic1 = Color(0xFFFF6A5D);
  static const semantic2 = Color(0xFF47C272);
}

Color getColorByBackground(context) {
  return Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : CustomColor.neutral1;
}

void selectThemeMode(BuildContext context) async {
  final newThemeMode = await showThemePickerDialog(context: context);
  print(newThemeMode);
}
