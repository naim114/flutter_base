import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/auth/sign_up.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/appbar/custom_appbar.dart';
import 'package:flutter_base/src/widgets/button/custom_button.dart';
import 'package:flutter_base/src/widgets/typography/custom_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../model/user_model.dart';
import '../../services/auth_services.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _authService = AuthService();

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool _submitted = false;
  Widget _buttonChild = const Text('Log In');

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

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
                        "Log In",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CustomTextField(
                        controller: emailController,
                        icon: const Icon(CupertinoIcons.at),
                        labelText: 'Email',
                        errorText:
                            _submitted == true && emailController.text.isEmpty
                                ? "Input can't be empty"
                                : _submitted == true &&
                                        !validateEmail(emailController)
                                    ? "Please enter the correct email"
                                    : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: CustomTextField(
                        controller: passwordController,
                        icon: const Icon(CupertinoIcons.padlock),
                        labelText: 'Password',
                        isPassword: true,
                        errorText: _submitted == true &&
                                passwordController.text.isEmpty
                            ? "Input can't be empty"
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
                            validateEmail(emailController)) {
                          // if validation success
                          final result = await _authService.signIn(
                            emailController.text,
                            passwordController.text,
                          );

                          print("Log In: ${result.toString()}");

                          if (result != null && result == false) {
                            Fluttertoast.showToast(
                                msg: "Could not sign in with credentials");
                          }
                        }

                        setState(() => _buttonChild = const Text("Log In"));
                      },
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
      ),
    );
  }

  bool _validateEmptyField() {
    return emailController.text.isEmpty || passwordController.text.isEmpty
        ? false
        : true;
  }
}
