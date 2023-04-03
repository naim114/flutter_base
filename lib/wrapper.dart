import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/auth/log_in.dart';
import 'package:flutter_base/src/features/main/index.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    return user == null ? const LogIn() : const FrontFrame();
  }
}
