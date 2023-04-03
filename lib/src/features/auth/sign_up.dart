import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/services/auth_services.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/appbar/custom_appbar.dart';
import 'package:flutter_base/src/widgets/button/custom_button.dart';
import 'package:flutter_base/src/widgets/typography/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _submitted = false;
  Widget _buttonChild = const Text('Log In');

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Padding(
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomTextField(
                        controller: nameController,
                        icon: const Icon(CupertinoIcons.person),
                        labelText: 'Enter Name',
                        errorText:
                            _submitted == true && nameController.text.isEmpty
                                ? "Input can't be empty"
                                : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CustomTextField(
                        controller: emailController,
                        icon: const Icon(CupertinoIcons.at),
                        labelText: 'Enter Email',
                        errorText:
                            _submitted == true && emailController.text.isEmpty
                                ? "Input can't be empty"
                                : _submitted == true && !_validateEmail()
                                    ? "Please enter the correct email"
                                    : null,
                      ),
                    ),
                    Divider(
                      color: getColorByBackground(context),
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: CustomTextField(
                        controller: passwordController,
                        icon: const Icon(CupertinoIcons.padlock),
                        labelText: 'Enter Password',
                        isPassword: true,
                        errorText: _submitted == true &&
                                passwordController.text.isEmpty
                            ? "Input can't be empty"
                            : _submitted == true && !_validatePassword()
                                ? 'Password has to be more than 8 character. Minimum 1 upper case, lower case, number and special character.'
                                : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomTextField(
                        controller: confirmPasswordController,
                        icon: const Icon(CupertinoIcons.padlock),
                        labelText: 'Confirm Password',
                        isPassword: true,
                        errorText: _submitted == true &&
                                confirmPasswordController.text.isEmpty
                            ? "Input can't be empty"
                            : !_validateConfirmPassword()
                                ? "Password and Confirm Password should have the same value"
                                : null,
                      ),
                    ),
                    customButton(
                      child: _buttonChild,
                      onPressed: () async {
                        setState(() => _submitted = true);
                        setState(() =>
                            _buttonChild = const CircularProgressIndicator(
                              color: Colors.white,
                            ));

                        if (_validateEmptyField() &&
                            _validateEmail() &&
                            _validatePassword() &&
                            _validateConfirmPassword()) {
                          // if validation success
                          final signUp = await _authService.signUp(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          print(signUp);

                          if (signUp == true && context.mounted) {
                            Navigator.pop(context);
                          } else {
                            setState(() => _buttonChild = const Text("Log In"));
                          }
                        } else {
                          setState(() => _buttonChild = const Text("Log In"));
                        }
                      },
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
      ),
    );
  }

  bool _validateEmptyField() {
    return nameController.text.isEmpty ||
            emailController.text.isEmpty ||
            passwordController.text.isEmpty ||
            confirmPasswordController.text.isEmpty
        ? false
        : true;
  }

  bool _validateEmail() {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return regex.hasMatch(emailController.text);
  }

  bool _validatePassword() {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(passwordController.text);
  }

  bool _validateConfirmPassword() {
    return passwordController.text == confirmPasswordController.text
        ? true
        : false;
  }
}
