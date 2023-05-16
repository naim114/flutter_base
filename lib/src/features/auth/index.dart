import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/features/auth/log_in.dart';
import 'package:news_app/src/features/auth/sign_up.dart';
import 'package:news_app/src/services/helpers.dart';
import 'package:news_app/src/widgets/appbar/custom_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/src/widgets/button/custom_pill_button.dart';

class AuthIndex extends StatelessWidget {
  const AuthIndex({super.key});

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // logoMain(context: context, height: 50),
            Container(
              child: Column(children: [
                SvgPicture.asset(
                  'assets/images/illustration.svg',
                  semanticsLabel: 'News at Your Fingertips',
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Stay Informed, Stay Ahead.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
            Container(
              child: Column(
                children: [
                  registerButton(context: context),
                  const SizedBox(height: 10),
                  loginButton(context: context),
                  const SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(height: 1.5),
                        children: [
                          TextSpan(
                            text: 'By signing up you accept the ',
                            style:
                                TextStyle(color: getColorByBackground(context)),
                          ),
                          TextSpan(
                            text: 'Term & Conditions',
                            style: TextStyle(
                              color: getColorByBackground(context),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('termnc');
                              },
                          ),
                          TextSpan(
                            text: ' and ',
                            style:
                                TextStyle(color: getColorByBackground(context)),
                          ),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(
                              color: getColorByBackground(context),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('pp');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget registerButton({
  required BuildContext context,
}) =>
    Container(
      decoration: BoxDecoration(
        color: CustomColor.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.25,
              color: isDarkTheme(context)
                  ? CupertinoColors.darkBackgroundGray
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Scroll indicator
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 40,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemGrey,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: const SizedBox(
                          height: 5,
                        ),
                      ),
                    ),
                    // Google
                    customPillButton(
                      context: context,
                      borderColor: CustomColor.primary,
                      fillColor: Colors.transparent,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/google.svg',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Register with Google',
                            style: TextStyle(
                              color: isDarkTheme(context)
                                  ? Colors.white
                                  : CustomColor.neutral1, // Text color
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Email
                    customPillButton(
                      context: context,
                      borderColor: CustomColor.primary,
                      fillColor: Colors.transparent,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.mail,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Register with Email',
                            style: TextStyle(
                              color: isDarkTheme(context)
                                  ? Colors.white
                                  : CustomColor.neutral1, // Text color
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );

Widget loginButton({
  required BuildContext context,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: CustomColor.primary,
          width: 2,
        ),
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.25,
              color: isDarkTheme(context)
                  ? CupertinoColors.darkBackgroundGray
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Scroll indicator
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 40,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemGrey,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: const SizedBox(
                          height: 5,
                        ),
                      ),
                    ),
                    // Google
                    customPillButton(
                      context: context,
                      borderColor: CustomColor.primary,
                      fillColor: Colors.transparent,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/google.svg',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: isDarkTheme(context)
                                  ? Colors.white
                                  : CustomColor.neutral1, // Text color
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Email
                    customPillButton(
                      context: context,
                      borderColor: CustomColor.primary,
                      fillColor: Colors.transparent,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LogIn()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.mail,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Continue with Email',
                            style: TextStyle(
                              color: isDarkTheme(context)
                                  ? Colors.white
                                  : CustomColor.neutral1, // Text color
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        child: Text(
          'Log In',
          style: TextStyle(
            color: isDarkTheme(context)
                ? Colors.white
                : CustomColor.primary, // Text color
            fontSize: 18,
          ),
        ),
      ),
    );
