import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/appbar/custom_appbar.dart';
import 'package:flutter_base/src/widgets/button/custom_button.dart';
import 'package:flutter_base/src/widgets/typography/custom_textfield.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        onPressed: () {
          Navigator.pop(context);
        },
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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CustomTextField(
                      icon: Icon(
                        CupertinoIcons.person,
                      ),
                      labelText: 'Enter Name',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CustomTextField(
                      icon: Icon(
                        CupertinoIcons.at,
                      ),
                      labelText: 'Enter Email',
                    ),
                  ),
                  Divider(
                    color: getColorByBackground(context),
                    indent: 10,
                    endIndent: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: CustomTextField(
                      icon: Icon(
                        CupertinoIcons.padlock,
                      ),
                      labelText: 'Enter Password',
                      isPassword: true,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CustomTextField(
                      icon: Icon(
                        CupertinoIcons.padlock,
                      ),
                      labelText: 'Confirm Password',
                      isPassword: true,
                    ),
                  ),
                  customButton(
                    child: const Text('Sign Up'),
                    onPressed: () {},
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: CustomColor.neutral2),
                      ),
                      TextSpan(
                        text: 'Log In',
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
