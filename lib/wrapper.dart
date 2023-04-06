import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/auth/log_in.dart';
import 'package:flutter_base/src/features/main/index.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel?>();

    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: CustomColor.primary,
                  rightDotColor: CustomColor.secondary,
                  size: 50,
                ),
              ),
            ),
          );
        } else {
          if (user == null) {
            return const LogIn();
          } else {
            return const FrontFrame();
          }
        }
      },
    );
  }
}
