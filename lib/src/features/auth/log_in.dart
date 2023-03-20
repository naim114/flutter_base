import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/auth/sign_up.dart';
import 'package:flutter_base/src/features/main/index.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/appbar/custom_appbar.dart';
import 'package:flutter_base/src/widgets/button/custom_button.dart';
import 'package:flutter_base/src/widgets/typography/custom_textfield.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        onPressed: () {},
        noBackButton: true,
        actions: [
          IconButton(
            icon: isDarkTheme(context)
                ? const Icon(CupertinoIcons.moon_fill)
                : const Icon(CupertinoIcons.sun_max_fill),
            color: getColorByBackground(context),
            onPressed: () => selectThemeMode(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CustomTextField(
                      icon: Icon(
                        CupertinoIcons.at,
                      ),
                      labelText: 'Email',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: CustomTextField(
                      icon: Icon(
                        CupertinoIcons.padlock,
                      ),
                      labelText: 'Password',
                      isPassword: true,
                    ),
                  ),
                  customButton(
                    child: const Text('Log In'),
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const FrontFrame(),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                ),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(color: CustomColor.neutral2),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(color: CustomColor.secondary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
