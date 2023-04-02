import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/auth/log_in.dart';
import 'package:flutter_base/src/features/main/index.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return user == null ? const LogIn() : const FrontFrame();
  }
}
