import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/auth/log_in.dart';
import 'package:flutter_base/src/features/auth/sign_up.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import 'src/theme/theme_mode_manager.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  MaterialColor primaryColorShades = const MaterialColor(
    0xFF643FDB,
    <int, Color>{
      50: Color.fromRGBO(100, 63, 219, .1),
      100: Color.fromRGBO(100, 63, 219, .2),
      200: Color.fromRGBO(100, 63, 219, .3),
      300: Color.fromRGBO(100, 63, 219, .4),
      400: Color.fromRGBO(100, 63, 219, .5),
      500: Color.fromRGBO(100, 63, 219, .6),
      600: Color.fromRGBO(100, 63, 219, .7),
      700: Color.fromRGBO(100, 63, 219, .8),
      800: Color.fromRGBO(100, 63, 219, .9),
      900: Color.fromRGBO(100, 63, 219, 1),
    },
  );

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: ExampleThemeModeManager(),
      placeholderWidget: const Center(
        child: CircularProgressIndicator(
          color: CustomColor.primary,
        ),
      ),
      builder: (ThemeMode themeMode) => MaterialApp(
        themeMode: themeMode,
        // DARK THEME
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: GoogleFonts.questrial().fontFamily,
          primarySwatch: primaryColorShades,
          primaryColor: CustomColor.primary,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),

        // LIGHT THEME
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Questrial',
          primarySwatch: primaryColorShades,
          primaryColor: CustomColor.primary,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: CustomColor.neutral1,
                displayColor: CustomColor.neutral1,
              ),
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            prefixIconColor: CustomColor.neutral1,
          ),
          iconTheme: const IconThemeData(
            color: CustomColor.neutral1,
          ),
          iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
                iconColor: MaterialStatePropertyAll(CustomColor.neutral1)),
          ),
        ),
        home: const LogIn(),
      ),
    );
  }
}
